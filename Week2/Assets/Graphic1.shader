// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:1,x:35310,y:33773,varname:node_1,prsc:2|diff-124-OUT,normal-9595-OUT,emission-2715-OUT,clip-9247-A,voffset-6015-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33204,y:31483,ptovrint:False,ptlb:Texture1,ptin:_Texture1,varname:node_1916,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-150-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:3,x:33411,y:32388,ptovrint:False,ptlb:Texture2,ptin:_Texture2,varname:node_1126,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9702-OUT;n:type:ShaderForge.SFN_Tex2d,id:4,x:33455,y:33045,ptovrint:False,ptlb:Texture3,ptin:_Texture3,varname:node_4544,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9152-UVOUT;n:type:ShaderForge.SFN_Add,id:5,x:34546,y:31847,varname:node_5,prsc:2|A-41-OUT,B-39-OUT,C-11-OUT,D-9796-OUT;n:type:ShaderForge.SFN_Multiply,id:11,x:33809,y:33028,varname:node_11,prsc:2|A-4-RGB,B-37-RGB;n:type:ShaderForge.SFN_Color,id:28,x:33533,y:31708,ptovrint:False,ptlb:Text1_color,ptin:_Text1_color,varname:node_3279,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Color,id:35,x:33624,y:32488,ptovrint:False,ptlb:Text2_color,ptin:_Text2_color,varname:node_5728,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:37,x:33628,y:33172,ptovrint:False,ptlb:Text3_color,ptin:_Text3_color,varname:node_9571,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:39,x:33804,y:32336,varname:node_39,prsc:2|A-3-RGB,B-35-RGB;n:type:ShaderForge.SFN_Multiply,id:41,x:33782,y:31885,varname:node_41,prsc:2|A-9180-OUT,B-28-RGB;n:type:ShaderForge.SFN_Multiply,id:104,x:34379,y:33110,varname:node_104,prsc:2|A-41-OUT,B-108-RGB;n:type:ShaderForge.SFN_Color,id:108,x:33709,y:32068,ptovrint:False,ptlb:Text1_Emission,ptin:_Text1_Emission,varname:node_6689,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:115,x:34328,y:33366,varname:node_115,prsc:2|A-39-OUT,B-117-RGB;n:type:ShaderForge.SFN_Color,id:117,x:33804,y:32488,ptovrint:False,ptlb:Text2_Emission,ptin:_Text2_Emission,varname:node_2369,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Add,id:124,x:34630,y:33785,varname:node_124,prsc:2|A-104-OUT,B-115-OUT,C-132-OUT,D-9809-OUT;n:type:ShaderForge.SFN_Multiply,id:132,x:34316,y:33501,varname:node_132,prsc:2|A-11-OUT,B-139-RGB;n:type:ShaderForge.SFN_Color,id:139,x:33809,y:33172,ptovrint:False,ptlb:Text3_Emission,ptin:_Text3_Emission,varname:node_9290,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Rotator,id:150,x:32891,y:31481,varname:node_150,prsc:2|UVIN-164-UVOUT,SPD-8742-OUT;n:type:ShaderForge.SFN_TexCoord,id:164,x:32440,y:31471,varname:node_164,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:8742,x:32671,y:31648,ptovrint:False,ptlb:Text1_rot,ptin:_Text1_rot,varname:node_1535,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Panner,id:8755,x:32760,y:32420,varname:node_8755,prsc:2,spu:-0.1,spv:0.1|UVIN-9121-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:9121,x:32441,y:32384,varname:node_9121,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:9143,x:32880,y:33196,ptovrint:False,ptlb:Text3_rot,ptin:_Text3_rot,varname:node_3349,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_Rotator,id:9152,x:33076,y:33008,varname:node_9152,prsc:2|UVIN-9165-UVOUT,SPD-9143-OUT;n:type:ShaderForge.SFN_TexCoord,id:9165,x:32614,y:33096,varname:node_9165,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:9178,x:32877,y:31210,varname:node_9178,prsc:2;n:type:ShaderForge.SFN_Frac,id:9179,x:33256,y:31210,varname:node_9179,prsc:2|IN-9188-OUT;n:type:ShaderForge.SFN_Multiply,id:9180,x:33533,y:31548,varname:node_9180,prsc:2|A-9179-OUT,B-2-RGB;n:type:ShaderForge.SFN_Slider,id:9187,x:32781,y:31349,ptovrint:False,ptlb:Text1_strobe,ptin:_Text1_strobe,varname:node_8647,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:3.595517,max:10;n:type:ShaderForge.SFN_Multiply,id:9188,x:33087,y:31210,varname:node_9188,prsc:2|A-9178-T,B-9187-OUT;n:type:ShaderForge.SFN_Tex2d,id:9247,x:34153,y:32941,ptovrint:False,ptlb:Mask,ptin:_Mask,varname:node_8490,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:9533,x:33829,y:32646,ptovrint:False,ptlb:Normal,ptin:_Normal,varname:node_9661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Normalize,id:9546,x:34086,y:32635,varname:node_9546,prsc:2|IN-9533-RGB;n:type:ShaderForge.SFN_Multiply,id:9595,x:34709,y:32744,varname:node_9595,prsc:2|A-9546-OUT,B-9598-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9598,x:34086,y:32787,ptovrint:False,ptlb:Normal Value,ptin:_NormalValue,varname:node_6690,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:9652,x:32917,y:32078,varname:node_9652,prsc:2|A-9662-OUT,B-9729-OUT;n:type:ShaderForge.SFN_Frac,id:9662,x:32692,y:31950,varname:node_9662,prsc:2|IN-9671-TSL;n:type:ShaderForge.SFN_Time,id:9671,x:32418,y:31832,varname:node_9671,prsc:2;n:type:ShaderForge.SFN_Add,id:9702,x:33108,y:32184,varname:node_9702,prsc:2|A-9652-OUT,B-8755-UVOUT;n:type:ShaderForge.SFN_ValueProperty,id:9729,x:32645,y:32158,ptovrint:False,ptlb:Text2_Panspeed,ptin:_Text2_Panspeed,varname:node_3028,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-1;n:type:ShaderForge.SFN_Tex2d,id:9782,x:34000,y:31108,ptovrint:False,ptlb:BaseTexture,ptin:_BaseTexture,varname:node_8084,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:9795,x:33892,y:31346,ptovrint:False,ptlb:BaseTextcolor,ptin:_BaseTextcolor,varname:node_5791,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:9796,x:34274,y:31291,varname:node_9796,prsc:2|A-9782-RGB,B-9795-RGB;n:type:ShaderForge.SFN_Multiply,id:9809,x:34304,y:33644,varname:node_9809,prsc:2|A-9796-OUT,B-9810-RGB;n:type:ShaderForge.SFN_Color,id:9810,x:34228,y:31513,ptovrint:False,ptlb:BaseTexture_emmision,ptin:_BaseTexture_emmision,varname:node_3124,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:4798,x:34137,y:34087,cmnt:Triangle Wave,varname:node_4798,prsc:2|A-4149-OUT,B-8128-OUT;n:type:ShaderForge.SFN_Color,id:8458,x:34593,y:34024,ptovrint:False,ptlb:Glow Color_copy,ptin:_GlowColor_copy,varname:_GlowColor_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:0.2391481,c3:0.1102941,c4:1;n:type:ShaderForge.SFN_Multiply,id:7794,x:34870,y:34254,cmnt:Glow,varname:node_7794,prsc:2|A-8458-RGB,B-8963-OUT,C-3497-OUT;n:type:ShaderForge.SFN_Multiply,id:6015,x:34842,y:34479,varname:node_6015,prsc:2|A-3497-OUT,B-2216-OUT,C-9724-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2216,x:34662,y:34459,ptovrint:False,ptlb:Bulge Scal3,ptin:_BulgeScal3,varname:_BulgeScale_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Relay,id:3497,x:34654,y:34340,varname:node_3497,prsc:2|IN-4436-OUT;n:type:ShaderForge.SFN_Power,id:4436,x:34341,y:34150,cmnt:Panning gradient,varname:node_4436,prsc:2|VAL-4798-OUT,EXP-1734-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1734,x:34177,y:34278,ptovrint:False,ptlb:Bulge Shape,ptin:_BulgeShape,varname:_BulgeShape_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Abs,id:4149,x:34002,y:33998,varname:node_4149,prsc:2|IN-8632-OUT;n:type:ShaderForge.SFN_Vector1,id:8128,x:34002,y:34134,varname:node_8128,prsc:2,v1:2;n:type:ShaderForge.SFN_Subtract,id:8632,x:33830,y:33998,varname:node_8632,prsc:2|A-1107-OUT,B-2544-OUT;n:type:ShaderForge.SFN_Frac,id:1107,x:33651,y:33946,varname:node_1107,prsc:2|IN-5706-OUT;n:type:ShaderForge.SFN_Vector1,id:2544,x:33651,y:34080,varname:node_2544,prsc:2,v1:0.5;n:type:ShaderForge.SFN_ComponentMask,id:5706,x:33480,y:33946,varname:node_5706,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-1352-UVOUT;n:type:ShaderForge.SFN_Panner,id:1352,x:33313,y:33946,varname:node_1352,prsc:2,spu:0.25,spv:0|UVIN-9270-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:9270,x:33150,y:33946,varname:node_9270,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Vector1,id:8963,x:34625,y:34236,cmnt:Glow Intesity,varname:node_8963,prsc:2,v1:1.2;n:type:ShaderForge.SFN_NormalVector,id:9724,x:34640,y:34540,prsc:2,pt:False;n:type:ShaderForge.SFN_Add,id:2715,x:35050,y:33957,varname:node_2715,prsc:2|A-124-OUT,B-7794-OUT;proporder:9782-2-3-4-28-35-37-108-117-139-8742-9143-9795-9187-9247-9533-9598-9729-9810-2216-1734-8458;pass:END;sub:END;*/

Shader "Shader Forge/Graphic1" {
    Properties {
        _BaseTexture ("BaseTexture", 2D) = "white" {}
        _Texture1 ("Texture1", 2D) = "white" {}
        _Texture2 ("Texture2", 2D) = "white" {}
        _Texture3 ("Texture3", 2D) = "white" {}
        _Text1_color ("Text1_color", Color) = (0,0,0,1)
        _Text2_color ("Text2_color", Color) = (1,1,1,1)
        _Text3_color ("Text3_color", Color) = (1,1,1,1)
        _Text1_Emission ("Text1_Emission", Color) = (0.5,0.5,0.5,1)
        _Text2_Emission ("Text2_Emission", Color) = (0.5,0.5,0.5,1)
        _Text3_Emission ("Text3_Emission", Color) = (1,1,1,1)
        _Text1_rot ("Text1_rot", Float ) = 0
        _Text3_rot ("Text3_rot", Float ) = 2
        _BaseTextcolor ("BaseTextcolor", Color) = (1,1,1,1)
        _Text1_strobe ("Text1_strobe", Range(0, 10)) = 3.595517
        _Mask ("Mask", 2D) = "white" {}
        _Normal ("Normal", 2D) = "bump" {}
        _NormalValue ("Normal Value", Float ) = 0
        _Text2_Panspeed ("Text2_Panspeed", Float ) = -1
        _BaseTexture_emmision ("BaseTexture_emmision", Color) = (0.5,0.5,0.5,1)
        _BulgeScal3 ("Bulge Scal3", Float ) = 0
        _BulgeShape ("Bulge Shape", Float ) = 0
        _GlowColor_copy ("Glow Color_copy", Color) = (1,0.2391481,0.1102941,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Texture1; uniform float4 _Texture1_ST;
            uniform sampler2D _Texture2; uniform float4 _Texture2_ST;
            uniform sampler2D _Texture3; uniform float4 _Texture3_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _BaseTexture; uniform float4 _BaseTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text1_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text2_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text3_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text1_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text2_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text3_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text1_rot)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text3_rot)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text1_strobe)
                UNITY_DEFINE_INSTANCED_PROP( float, _NormalValue)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text2_Panspeed)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseTextcolor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseTexture_emmision)
                UNITY_DEFINE_INSTANCED_PROP( float4, _GlowColor_copy)
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeScal3)
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeShape)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_9193 = _Time;
                float _BulgeShape_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeShape );
                float node_3497 = pow((abs((frac((o.uv0+node_9193.g*float2(0.25,0)).r)-0.5))*2.0),_BulgeShape_var);
                float _BulgeScal3_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeScal3 );
                v.vertex.xyz += (node_3497*_BulgeScal3_var*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float _NormalValue_var = UNITY_ACCESS_INSTANCED_PROP( Props, _NormalValue );
                float3 normalLocal = (normalize(_Normal_var.rgb)*_NormalValue_var);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                clip(_Mask_var.a - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 node_9178 = _Time;
                float _Text1_strobe_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_strobe );
                float4 node_9193 = _Time;
                float _Text1_rot_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_rot );
                float node_150_ang = node_9193.g;
                float node_150_spd = _Text1_rot_var;
                float node_150_cos = cos(node_150_spd*node_150_ang);
                float node_150_sin = sin(node_150_spd*node_150_ang);
                float2 node_150_piv = float2(0.5,0.5);
                float2 node_150 = (mul(i.uv0-node_150_piv,float2x2( node_150_cos, -node_150_sin, node_150_sin, node_150_cos))+node_150_piv);
                float4 _Texture1_var = tex2D(_Texture1,TRANSFORM_TEX(node_150, _Texture1));
                float4 _Text1_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_color );
                float3 node_41 = ((frac((node_9178.g*_Text1_strobe_var))*_Texture1_var.rgb)*_Text1_color_var.rgb);
                float4 _Text1_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_Emission );
                float4 node_9671 = _Time;
                float _Text2_Panspeed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_Panspeed );
                float2 node_9702 = ((frac(node_9671.r)*_Text2_Panspeed_var)+(i.uv0+node_9193.g*float2(-0.1,0.1)));
                float4 _Texture2_var = tex2D(_Texture2,TRANSFORM_TEX(node_9702, _Texture2));
                float4 _Text2_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_color );
                float3 node_39 = (_Texture2_var.rgb*_Text2_color_var.rgb);
                float4 _Text2_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_Emission );
                float _Text3_rot_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_rot );
                float node_9152_ang = node_9193.g;
                float node_9152_spd = _Text3_rot_var;
                float node_9152_cos = cos(node_9152_spd*node_9152_ang);
                float node_9152_sin = sin(node_9152_spd*node_9152_ang);
                float2 node_9152_piv = float2(0.5,0.5);
                float2 node_9152 = (mul(i.uv0-node_9152_piv,float2x2( node_9152_cos, -node_9152_sin, node_9152_sin, node_9152_cos))+node_9152_piv);
                float4 _Texture3_var = tex2D(_Texture3,TRANSFORM_TEX(node_9152, _Texture3));
                float4 _Text3_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_color );
                float3 node_11 = (_Texture3_var.rgb*_Text3_color_var.rgb);
                float4 _Text3_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_Emission );
                float4 _BaseTexture_var = tex2D(_BaseTexture,TRANSFORM_TEX(i.uv0, _BaseTexture));
                float4 _BaseTextcolor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseTextcolor );
                float3 node_9796 = (_BaseTexture_var.rgb*_BaseTextcolor_var.rgb);
                float4 _BaseTexture_emmision_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseTexture_emmision );
                float3 node_124 = ((node_41*_Text1_Emission_var.rgb)+(node_39*_Text2_Emission_var.rgb)+(node_11*_Text3_Emission_var.rgb)+(node_9796*_BaseTexture_emmision_var.rgb));
                float3 diffuseColor = node_124;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _GlowColor_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _GlowColor_copy );
                float _BulgeShape_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeShape );
                float node_3497 = pow((abs((frac((i.uv0+node_9193.g*float2(0.25,0)).r)-0.5))*2.0),_BulgeShape_var);
                float3 emissive = (node_124+(_GlowColor_copy_var.rgb*1.2*node_3497));
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _Texture1; uniform float4 _Texture1_ST;
            uniform sampler2D _Texture2; uniform float4 _Texture2_ST;
            uniform sampler2D _Texture3; uniform float4 _Texture3_ST;
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            uniform sampler2D _Normal; uniform float4 _Normal_ST;
            uniform sampler2D _BaseTexture; uniform float4 _BaseTexture_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text1_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text2_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text3_color)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text1_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text2_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Text3_Emission)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text1_rot)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text3_rot)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text1_strobe)
                UNITY_DEFINE_INSTANCED_PROP( float, _NormalValue)
                UNITY_DEFINE_INSTANCED_PROP( float, _Text2_Panspeed)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseTextcolor)
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseTexture_emmision)
                UNITY_DEFINE_INSTANCED_PROP( float4, _GlowColor_copy)
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeScal3)
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeShape)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 node_5309 = _Time;
                float _BulgeShape_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeShape );
                float node_3497 = pow((abs((frac((o.uv0+node_5309.g*float2(0.25,0)).r)-0.5))*2.0),_BulgeShape_var);
                float _BulgeScal3_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeScal3 );
                v.vertex.xyz += (node_3497*_BulgeScal3_var*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
                float _NormalValue_var = UNITY_ACCESS_INSTANCED_PROP( Props, _NormalValue );
                float3 normalLocal = (normalize(_Normal_var.rgb)*_NormalValue_var);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                clip(_Mask_var.a - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 node_9178 = _Time;
                float _Text1_strobe_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_strobe );
                float4 node_5309 = _Time;
                float _Text1_rot_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_rot );
                float node_150_ang = node_5309.g;
                float node_150_spd = _Text1_rot_var;
                float node_150_cos = cos(node_150_spd*node_150_ang);
                float node_150_sin = sin(node_150_spd*node_150_ang);
                float2 node_150_piv = float2(0.5,0.5);
                float2 node_150 = (mul(i.uv0-node_150_piv,float2x2( node_150_cos, -node_150_sin, node_150_sin, node_150_cos))+node_150_piv);
                float4 _Texture1_var = tex2D(_Texture1,TRANSFORM_TEX(node_150, _Texture1));
                float4 _Text1_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_color );
                float3 node_41 = ((frac((node_9178.g*_Text1_strobe_var))*_Texture1_var.rgb)*_Text1_color_var.rgb);
                float4 _Text1_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text1_Emission );
                float4 node_9671 = _Time;
                float _Text2_Panspeed_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_Panspeed );
                float2 node_9702 = ((frac(node_9671.r)*_Text2_Panspeed_var)+(i.uv0+node_5309.g*float2(-0.1,0.1)));
                float4 _Texture2_var = tex2D(_Texture2,TRANSFORM_TEX(node_9702, _Texture2));
                float4 _Text2_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_color );
                float3 node_39 = (_Texture2_var.rgb*_Text2_color_var.rgb);
                float4 _Text2_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text2_Emission );
                float _Text3_rot_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_rot );
                float node_9152_ang = node_5309.g;
                float node_9152_spd = _Text3_rot_var;
                float node_9152_cos = cos(node_9152_spd*node_9152_ang);
                float node_9152_sin = sin(node_9152_spd*node_9152_ang);
                float2 node_9152_piv = float2(0.5,0.5);
                float2 node_9152 = (mul(i.uv0-node_9152_piv,float2x2( node_9152_cos, -node_9152_sin, node_9152_sin, node_9152_cos))+node_9152_piv);
                float4 _Texture3_var = tex2D(_Texture3,TRANSFORM_TEX(node_9152, _Texture3));
                float4 _Text3_color_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_color );
                float3 node_11 = (_Texture3_var.rgb*_Text3_color_var.rgb);
                float4 _Text3_Emission_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Text3_Emission );
                float4 _BaseTexture_var = tex2D(_BaseTexture,TRANSFORM_TEX(i.uv0, _BaseTexture));
                float4 _BaseTextcolor_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseTextcolor );
                float3 node_9796 = (_BaseTexture_var.rgb*_BaseTextcolor_var.rgb);
                float4 _BaseTexture_emmision_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseTexture_emmision );
                float3 node_124 = ((node_41*_Text1_Emission_var.rgb)+(node_39*_Text2_Emission_var.rgb)+(node_11*_Text3_Emission_var.rgb)+(node_9796*_BaseTexture_emmision_var.rgb));
                float3 diffuseColor = node_124;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma target 3.0
            uniform sampler2D _Mask; uniform float4 _Mask_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeScal3)
                UNITY_DEFINE_INSTANCED_PROP( float, _BulgeShape)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 node_6536 = _Time;
                float _BulgeShape_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeShape );
                float node_3497 = pow((abs((frac((o.uv0+node_6536.g*float2(0.25,0)).r)-0.5))*2.0),_BulgeShape_var);
                float _BulgeScal3_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BulgeScal3 );
                v.vertex.xyz += (node_3497*_BulgeScal3_var*v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float4 _Mask_var = tex2D(_Mask,TRANSFORM_TEX(i.uv0, _Mask));
                clip(_Mask_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
