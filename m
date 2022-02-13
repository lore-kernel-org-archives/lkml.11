Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF13C4332F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 20:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiBMUZh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 15:25:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMUZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:25:35 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F0532E0;
        Sun, 13 Feb 2022 12:25:27 -0800 (PST)
Received: from g550jk.localnet (mobiledyn-62-240-134-32.mrsn.at [62.240.134.32])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CE19FC6663;
        Sun, 13 Feb 2022 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1644783926; bh=NfYs+/rE0OPemkL440C+e9FYw7oebJ3inMJW9g2wXzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J9mv8OQ/Khh5a/u3yqnEhp6twENlt97jjepo71bS9QBWwkOAIlJRyPQjBaM0FwECT
         zNoB9+SapnTwqK/h+yoK87IoqS9Y4ein1Up0skUFQ00KUb/U9tjW3J8w86lGBoLT2s
         cPGj2KsPda86p4a/wqDlHeCHZ/kyI9sJ+YiWOt0Q=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/15] arm64: dts: qcom: Add MSM8953+PM8953 device tree
Date:   Sun, 13 Feb 2022 21:25:24 +0100
Message-ID: <2497719.tdWV9SEqCh@g550jk>
In-Reply-To: <YfhlCkb3XUvU8ae1@builder.lan>
References: <20220112194118.178026-1-luca@z3ntu.xyz> <20220112194118.178026-14-luca@z3ntu.xyz> <YfhlCkb3XUvU8ae1@builder.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Montag, 31. J=E4nner 2022 23:39:06 CET Bjorn Andersson wrote:
> On Wed 12 Jan 13:41 CST 2022, Luca Weiss wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > The combination MSM8953 + PM8953 is commonly used, so add a
> > device tree where common power supplies etc. can be configured.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>=20
> I would prefer if we stick with the current scheme and just push this
> into the device dts (or possibly some vendor-common dtsi if that's
> applicable).
>=20
> Simply just to follow what we do on other platforms.

Sure, will do in v2.

>=20
>=20
> PS. I see some patches has been applied, but as you resubmit this
> series please split it per maintainer to make it obvious to each
> maintainer that they should pick their part(s).

What do you mean by this? Send one series per maintainer? Or something else=
?=20

Currently when making the patches I don't really "care" about who maintains=
=20
what, my git send-email setup picks the relevant people for CC.

Sometimes there's also multiple maintainers/trees listed for one file, not =
sure=20
what to do there...=20

Regards
Luca

>=20
> Thanks,
> Bjorn
>=20
> > ---
> >=20
> >  arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi | 50 ++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> > b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi new file mode 100644
> > index 000000000000..b5f20fc9488e
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
> > @@ -0,0 +1,50 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> > +
> > +#include "msm8953.dtsi"
> > +#include "pm8953.dtsi"
> > +
> > +&hsusb_phy {
> > +	vdd-supply =3D <&pm8953_l3>;
> > +	vdda-pll-supply =3D <&pm8953_l7>;
> > +	vdda-phy-dpdm-supply =3D <&pm8953_l13>;
> > +};
> > +
> > +&sdhc_1 {
> > +	vmmc-supply =3D <&pm8953_l8>;
> > +	vqmmc-supply =3D <&pm8953_l5>;
> > +};
> > +
> > +&sdhc_2 {
> > +	vmmc-supply =3D <&pm8953_l11>;
> > +	vqmmc-supply =3D <&pm8953_l12>;
> > +};
> > +
> > +&rpm_requests {
> > +	smd_rpm_regulators: pm8953-regulators {
> > +		compatible =3D "qcom,rpm-pm8953-regulators";
> > +
> > +		pm8953_s1: s1 {};
> > +		pm8953_s3: s3 {};
> > +		pm8953_s4: s4 {};
> > +
> > +		pm8953_l1: l1 {};
> > +		pm8953_l2: l2 {};
> > +		pm8953_l3: l3 {};
> > +		pm8953_l5: l5 {};
> > +		pm8953_l6: l6 {};
> > +		pm8953_l7: l7 {};
> > +		pm8953_l8: l8 {};
> > +		pm8953_l9: l9 {};
> > +		pm8953_l10: l10 {};
> > +		pm8953_l11: l11 {};
> > +		pm8953_l12: l12 {};
> > +		pm8953_l13: l13 {};
> > +		pm8953_l15: l15 {};
> > +		pm8953_l16: l16 {};
> > +		pm8953_l17: l17 {};
> > +		pm8953_l19: l19 {};
> > +		pm8953_l22: l22 {};
> > +		pm8953_l23: l23 {};
> > +	};
> > +};




