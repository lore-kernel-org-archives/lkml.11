Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D0C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 11:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355377AbiCYLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbiCYLVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:21:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583EA5A08E;
        Fri, 25 Mar 2022 04:19:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 87AE11F4614E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648207177;
        bh=sKCePReqp4ZJymOSI9J4lq/V8FQUX26+JNamqgOmKYw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lv5yRVc2k0I/c7KDjggKiXuVEGwwpOMPNMal8CNUvBFOrMrqLbUStd9sfpti2XuWw
         GxU0GJtnL1xMlub9WQk9bTsjtARZ/Ymf7AwFc6HD9G6C51OuCKYkdA/HJUWVFQFEA/
         GS+UTABwBtCVTu3JM5neiu02qw5FlfH9Gl3J3xkgw9FwDbqWi3RADA2Qw3ysHkSQQk
         RWXdpD8UBFHGt3il4TVA6xk/YQzpJhUvzrTows798nBsQZtBK/eN34Vaw6EzZwFThw
         787bqLLkZkRgRKoIeUBTL3ypMt+slpfdmWzph9LzMjkRpG6KIuXqoAFG4fGTwhQ5rW
         YVxjUdgARBZmA==
Message-ID: <c08cd648-f42c-b8f6-41a5-172fdb47d27e@collabora.com>
Date:   Fri, 25 Mar 2022 08:19:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-bsh-smm-s2pro: Add
 tlv320aic31xx audio card node
Content-Language: en-US
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
 <20220210134049.32576-2-ariel.dalessandro@collabora.com>
 <CAOMZO5DuB4d1243H46d1=heiNiz+pQVkjrGU+zV_r3GFKRTZfQ@mail.gmail.com>
 <d748d03d-4e9c-50a5-6c9e-089ec44a2540@collabora.com>
In-Reply-To: <d748d03d-4e9c-50a5-6c9e-089ec44a2540@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 3/17/22 15:47, Ariel D'Alessandro wrote:
> Hi Fabio,
> 
> On 3/10/22 09:29, Fabio Estevam wrote:
>> Hi Ariel,
>>
>> On Thu, Feb 10, 2022 at 10:41 AM Ariel D'Alessandro
>> <ariel.dalessandro@collabora.com> wrote:
>>
>>> +&i2c2 {
>>> +       clock-frequency = <400000>;
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&pinctrl_i2c2>;
>>> +       status = "okay";
>>> +
>>> +       codec: tlv320dac3101@18 {
>>> +               #sound-dai-cells = <0>;
>>> +               compatible = "ti,tlv320dac3101";
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&pinctrl_dac_rst>;
>>> +               reg = <0x18>;
>>> +
>>> +               ai31xx-micbias-vg = <MICBIAS_AVDDV>;
>>> +
>>> +               HPVDD-supply = <&buck4_reg>;
>>> +               SPRVDD-supply = <&vdd_input>;
>>> +               SPLVDD-supply = <&vdd_input>;
>>> +               AVDD-supply = <&buck4_reg>;
>>> +               IOVDD-supply = <&buck4_reg>;
>>> +               DVDD-supply = <&buck5_reg>;
>>> +               reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
>>> +
>>> +               clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
>>> +               clock-names = "mclk";
>>
>> The clocks and clock-names properties are not documented in the codec bindings.
>>
>> Also, the driver does not use call clk_get() on this mclk clock.
>>
>> You should drop the clocks and clock-names properties.
> 
> The sound card driver is calling clk_get() on the codec's clock. See
> sound/soc/fsl/fsl-asoc-card.c:
> 
>     /* Get the MCLK rate only, and leave it controlled by CODEC drivers */
>     if (codec_dev) {
>         struct clk *codec_clk = clk_get(codec_dev, NULL);
> 
>         if (!IS_ERR(codec_clk)) {
>             priv->codec_priv.mclk_freq = clk_get_rate(codec_clk);
>             clk_put(codec_clk);
>         }
>     }

Do you have any other comments on this one? Otherwise, could you perhaps
ack this patch? See latest version:
  [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx audio
card node

Thanks
Ariel
