Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 07:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377728AbiDDHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377725AbiDDHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:43:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C8C3B00A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:41:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B79AB80EDA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C9C2BBE4;
        Mon,  4 Apr 2022 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649058081;
        bh=SFEBOkVBt2v7eUVd6t7tUEMAgkCh+TwoOUWan0N1Hos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k35KrcyPmVFXi+Gy2GWiGVFUahIER0Mp79Rv4sRPCzurenul1pPyA3KyvosugQcTS
         1+U+my+IW7vsGQkB101wUgRGopoe3W6hwqsnlrk+cyQ0w1KWqrapbpTXU9huTNI55l
         5+j4pPfyXEhouT+Tug+qkeZfesxoQXOvH69b/TkD6SsQTst/lkSYrIeHQDZ+wTWV8I
         BT4L/ZteXWbk7077YCQcQDJZG8kvn5viavEgZlv894QuZU470ZY90w9wuEItr4SU9B
         XWIJrmDy6A+DkA2+ho3qluOUaZJrVaqoCHTVOB53PzqkSYJtAk7C1hgtQZlvsQvq95
         M6mphAauWj74Q==
Date:   Mon, 4 Apr 2022 08:41:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        tangmeng@uniontech.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] ASoC: amd: Fix an ignored error return from
 platform_get_irq_byname()
Message-ID: <YkqhHLwwhlJxqgmJ@sirena.org.uk>
References: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZxoYiHOv0fHvjypM"
Content-Disposition: inline
In-Reply-To: <20220304004543.11797-1-yang.lee@linux.alibaba.com>
X-Cookie: A rolling disk gathers no MOS.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZxoYiHOv0fHvjypM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 04, 2022 at 08:45:43AM +0800, Yang Li wrote:
> The return from the call to platform_get_irq_byname() is int, it can be
> a negative error code, however this is being assigned to an unsigned
> int variable 'adata->i2s_irq', so assign the value to 'ret' concurrently
> to solve this problem without affecting other functions.

This doesn't apply against current code, please check and resend.

--ZxoYiHOv0fHvjypM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJKoRsACgkQJNaLcl1U
h9BT8gf8CSb8vfR5YFVec3em+YC6KNuko+8bu/rJE2FhxYDaW0+TitAAQbNhfhR+
/2NrU8KwenZTLE32B0MAOFYEPpXCITV+6ObDeXiDRQ773oBso8cMdEt87sh+nQNj
16ld/gg6nGG5Eym/8gwsMZ0tOkOAlLMwW3ZTeSnspZNFykPne0/8UPC+rpigHY2o
Nk1Jg1/XlihxB9I1yzvZQDTZKErxmVxsKWiYzVDyxQrB7/rroV/TfARFipOOcsPy
mOiuj+jtbl/lIRToLcravIOG8qRNCZaO5Eaqc9GtfAV1B7FZAAGBAC6bxHq5tbwy
xCj2phXjjXH0PqU8sAm4Mu2THhCsHA==
=mzRX
-----END PGP SIGNATURE-----

--ZxoYiHOv0fHvjypM--
