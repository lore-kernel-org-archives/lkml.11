Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD15C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiBKPP2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 10:15:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbiBKPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:15:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6BB17;
        Fri, 11 Feb 2022 07:15:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E3A661FE0;
        Fri, 11 Feb 2022 15:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D12EC340E9;
        Fri, 11 Feb 2022 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644592519;
        bh=IBFj2X+hcyPR39ZMQ3rlleTF8vNjd5w2MnpIK3BBRMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmGCHoL2jBqJx8fSZnFJir8mkhPKSgxt2JUHRSn60wV1qepXUXKX5nrall0vTrbG6
         b/4Kyddinm/0jrcIJnuDm/pPNxU2mm0I3mbiSPOQX80EEtFmpeLDb7b8vLPKk3s/Ro
         GKEDYUaWCIpvV3t4nrNROIi6XxRbm0NC9G/eyxfe+7FSsM8lOaTMH4SThmDZoM7pc/
         XikLLCFV3CnMYX1CqbZm0O6V79kllMYeXpgsHA5Hcfx5KUOSJfNJI2bsow6rSTEjel
         dLIwQcvks95mIbWaUlz2dw3PpzeUZbmP/8ZLz6gDeCZ9gqYi9pJZQ+kLVQxoE7fpwE
         LvfbdduK+f4FQ==
Date:   Fri, 11 Feb 2022 15:15:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] ASoC: mediatek: mt8186: support hw gain in
 platform driver
Message-ID: <YgZ9gadN8RksWeWN@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
 <20220211103818.8266-6-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c+ZpsOQ7A1I9zFvP"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-6-jiaxin.yu@mediatek.com>
X-Cookie: do {
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c+ZpsOQ7A1I9zFvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:08PM +0800, Jiaxin Yu wrote:

Again, mostly looks good just some minor issues (I've not repeated some
that applied to the prior code):

> +static const struct snd_kcontrol_new mtk_hw_gain2_in_ch1_mix[] = {
> +	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN15,
> +				    I_ADDA_UL_CH1, 1, 0),
> +};

These end up as regular user visible controls so should have standard
control names - in this case ending in Switch since it's a simple
on/off.  A similar issue was there in the earlier patches.

> +static const struct snd_kcontrol_new mtk_hw_gain_controls[] = {
> +	SOC_SINGLE("HW Gain 1", AFE_GAIN1_CON1,
> +		   GAIN1_TARGET_SFT, GAIN1_TARGET_MASK, 0),
> +	SOC_SINGLE("HW Gain 2", AFE_GAIN2_CON1,
> +		   GAIN2_TARGET_SFT, GAIN2_TARGET_MASK, 0),

These should have standard names like "HW 1 Volume" so userspace has a
better idea how to display them.

--c+ZpsOQ7A1I9zFvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGfYAACgkQJNaLcl1U
h9Ct/Af/SB+lHd2ZvAn42VmwpobHVEpUjwZsElRbAQHPqUKPY43uoQ75NXOvyRQS
HLaoNrQ0kkAVtNBtcolPvRac1ke9kTDEapfuhrUuv4QrgtdgRG3N6bL+m+dyQ6g5
33pIVvYTByz9HsJbzdSFqP527RJqmIUMGucj/p91edb9vTx/SEUZSuj6qqlohr2h
eVoa/P+QCK9bs29/EAD3HmucuJispsMgmntjOE9sYcGFmMDydZSHmyBozPDUuEJ0
S/8o/RVRY7h/KFKLAcc6+kSH4SctBryW4lXtdbZzueBFSefbMzjcHePyeJ0qox5N
Xa9RTpXYvvkNT7fsmvi3+zf0sBZGrw==
=22jY
-----END PGP SIGNATURE-----

--c+ZpsOQ7A1I9zFvP--
