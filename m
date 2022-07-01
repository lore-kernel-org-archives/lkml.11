Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA5CCA479
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiGASta (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGASt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:49:28 -0400
X-Greylist: delayed 156 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 11:49:27 PDT
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809140A09
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 11:49:27 -0700 (PDT)
Date:   Fri, 01 Jul 2022 18:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1656701366; x=1656960566;
        bh=zQWT4Uc8+YmYw2TxYPvOLJlF/WYStwcBkfDP+kL3slk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=jwXHH/O0q5vKDe5ybHjy1io/I/lEKQhLM3MQOa4UEg50DEOZgwcj/6/yjxJ63SY9h
         WpGaaIQrxEXOJsPX31nEh0+a+oRv1Oi4OGr7RoghUe5MhCPq8XXxJpbliA7BpmsYME
         hbW2uXzBo2MpLL8bZ8Ezer6gywYTyB9lsFt9tzHc=
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
Message-ID: <d12442a6-a0f1-0cb4-caa0-b7bb22fff28d@connolly.tech>
In-Reply-To: <20220505022706.1692554-3-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org> <20220505022706.1692554-3-bjorn.andersson@linaro.org>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/05/2022 03:27, Bjorn Andersson wrote:
> The DB845c has 4 "user LEDs", the last one is already supported as it's
> just wired to a gpio. Now that the LPG binding is in place we can wire
> up the other 3 LEDs as well.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot=
/dts/qcom/sdm845-db845c.dts
> index 194ebeb3259c..e4d3de0a1e6d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -5,6 +5,7 @@
>
>   /dts-v1/;
>
> +#include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>   #include <dt-bindings/sound/qcom,q6afe.h>
> @@ -606,6 +607,36 @@ resin {
>   =09};
>   };
>
> +&pmi8998_lpg {
> +=09status =3D "okay";
> +
> +=09qcom,power-source =3D <1>;
> +
> +=09led@3 {
> +=09=09reg =3D <3>;
> +=09=09color =3D <LED_COLOR_ID_GREEN>;
> +=09=09function =3D LED_FUNCTION_HEARTBEAT;
> +=09=09function-enumerator =3D <3>;
> +
> +=09=09linux,default-trigger =3D "heartbeat";
> +=09=09default-state =3D "on";
> +=09};
> +
> +=09led@4 {
> +=09=09reg =3D <4>;
> +=09=09color =3D <LED_COLOR_ID_GREEN>;
> +=09=09function =3D LED_FUNCTION_INDICATOR;
> +=09=09function-enumerator =3D <2>;
> +=09};
> +
> +=09led@5 {
> +=09=09reg =3D <5>;
> +=09=09color =3D <LED_COLOR_ID_GREEN>;
> +=09=09function =3D LED_FUNCTION_INDICATOR;
> +=09=09function-enumerator =3D <1>;
> +=09};
> +};
> +
>   /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
>   &q6afedai {
>   =09qi2s@22 {
> --
> 2.35.1
>

--
Kind Regards,
Caleb

