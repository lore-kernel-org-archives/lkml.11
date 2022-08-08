Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D59C25B0C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiHHNC7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHHNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7961C19
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90B28B80DDE
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EB9C433C1;
        Mon,  8 Aug 2022 13:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659963774;
        bh=Y8bmsXXKij7lEy5S8s5wm5b84NlBl5gdqCpLIq6bWyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzstylNMSKuRv+IxerYMrCuB63ceyCVrf1n+hK0Wh6BNLdFb9yYqlLeD6rf7x99g6
         +dC/KBPU4ATAzjCrzJ5mtC6vX72wWzygpxvvBVwbJS5o/9vmJVsv52FjnB+ZhzQSJv
         vj9qyffDOknaY6yZHE5Ya3jH9Ao4mMA9qg+eU8RMPuCNbO8xcNu1NYHMQU4H8rJlfF
         RlDwco+ThvSgHh3j2dyiZol52kx4hS7ZgQW61RS8t5+hD10cJQw8uU35l/GIPF5/C6
         LR6QqOSy7Os8KW0KMlZWGKImoGHUeLTWZyLfeK9lz5o7zPN96xkMue94kPSF5ptmId
         Zetw+zsC4nt8Q==
Date:   Mon, 8 Aug 2022 14:02:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/5] regmap: mmio: Drop unneeded and duplicative
 checks around CLK calls
Message-ID: <YvEJefFk7bqW9EpZ@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cMx/71A40yRPJXOW"
Content-Disposition: inline
In-Reply-To: <20220805205321.19452-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Are we running light with overbyte?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cMx/71A40yRPJXOW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2022 at 11:53:18PM +0300, Andy Shevchenko wrote:

> The commit 6b8e090ecc3d ("regmap: use IS_ERR() to check clk_get()
> results") assumes that CLK calls return the error pointer when clock
> is not found. However in the current code the described situation
> is simply impossible, because the regmap won't be created with
> missed clock if requested. The only way when it can be the case is
> what the above mentioned commit introduced by itself, when clock is
> not provided.

> Taking above into consideration, effectively revert the commit
> 6b8e090ecc3d and while at it, drop unneeded NULL checks since CLK
> calls are NULL-aware.

I don't understand the supposed benefit of this.  Yes, the clk API does
currently accept NULL as a valid clock and returns it as a dummy but
explicitly taking advantage of that in the way that this does just feels
more sloppy than the current behaviour.

--cMx/71A40yRPJXOW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxCXgACgkQJNaLcl1U
h9DMOwf/eNFWkdchMn3cZkkl3lmpPaqIgqMyLV9N3izOdCxpfgwskCLw1iLwL9D6
jrVr/MMECyex1hR9ZyLn5FJh5NKH0Wban6igjr8Edj7KhqeL5fE6FmzBg4inkPq3
10r2wDq+DbS83GMFLyi+8TXSbHe75+fVBLvBddqObcoXMds//CbHU7v9YIWo6dZS
d20Xb6dMHRIbel0Qh2NJOGrDgh+DEPQWkUH2VMiCPQsj/xObDp6oRSWE7nNwn/XK
je/5TI9D6acRsfeil9L09QDqVX0DI8syrmxDCiiCll8CBtItWMuaj4fGWsc+0u2C
9q7TxR8oOl+03RxUZoRc9IGy33bqEg==
=+Nfn
-----END PGP SIGNATURE-----

--cMx/71A40yRPJXOW--
