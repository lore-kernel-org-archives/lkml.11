Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4102BC4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 14:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiBLOxg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 09:53:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBLOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:53:32 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ACE214;
        Sat, 12 Feb 2022 06:53:29 -0800 (PST)
Date:   Sat, 12 Feb 2022 14:53:05 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v14 2/9] dt-bindings: display: Add ingenic,jz4780-dw-hdmi
 DT Schema
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>
Message-Id: <HC577R.0N5F78NY98FN1@crapouillou.net>
In-Reply-To: <c806c6007f7bb090bf96ff6bd827f03e88bf4712.1644675566.git.hns@goldelico.com>
References: <cover.1644675566.git.hns@goldelico.com>
        <c806c6007f7bb090bf96ff6bd827f03e88bf4712.1644675566.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam., févr. 12 2022 at 15:19:20 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Add DT bindings for the hdmi driver for the Ingenic JZ4780 SoC.
> Based on .txt binding from Zubair Lutfullah Kakakhel
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch pushed to drm-misc-next, thanks!

Cheers,
-Paul

> ---
>  .../display/bridge/ingenic,jz4780-hdmi.yaml   | 82 
> +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 
> Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> 
> diff --git 
> a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml 
> b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> new file mode 100644
> index 0000000000000..b8219eab4475a
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: 
> http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Ingenic JZ4780 HDMI Transmitter
> +
> +maintainers:
> +  - H. Nikolaus Schaller <hns@goldelico.com>
> +
> +description: |
> +  The HDMI Transmitter in the Ingenic JZ4780 is a Synopsys 
> DesignWare HDMI 1.4
> +  TX controller IP with accompanying PHY IP.
> +
> +allOf:
> +  - $ref: synopsys,dw-hdmi.yaml#
> +
> +properties:
> +  compatible:
> +    const: ingenic,jz4780-dw-hdmi
> +
> +  reg-io-width:
> +    const: 4
> +
> +  clocks:
> +    maxItems: 2
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input from LCD controller output.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Link to the HDMI connector.
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - ports
> +  - reg-io-width
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
> +
> +    hdmi: hdmi@10180000 {
> +        compatible = "ingenic,jz4780-dw-hdmi";
> +        reg = <0x10180000 0x8000>;
> +        reg-io-width = <4>;
> +        ddc-i2c-bus = <&i2c4>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <3>;
> +        clocks = <&cgu JZ4780_CLK_AHB0>, <&cgu JZ4780_CLK_HDMI>;
> +        clock-names = "iahb", "isfr";
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            hdmi_in: port@0 {
> +                reg = <0>;
> +                dw_hdmi_in: endpoint {
> +                    remote-endpoint = <&jz4780_lcd_out>;
> +                };
> +            };
> +            hdmi_out: port@1 {
> +                reg = <1>;
> +                dw_hdmi_out: endpoint {
> +                    remote-endpoint = <&hdmi_con>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> --
> 2.33.0
> 


