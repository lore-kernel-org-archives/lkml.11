Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC419C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiC3JUh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiC3JUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:20:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1822AC6E;
        Wed, 30 Mar 2022 02:18:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94042B81BB5;
        Wed, 30 Mar 2022 09:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E681C340EE;
        Wed, 30 Mar 2022 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648631927;
        bh=aVrqvODcydDKmqfXUiGFmQmS2YYivT8aXnaV3vGqTVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETS+h89+1a8HgdOZdMoxpsku+eFq+yBSyCsyvVmdbSAgYUGwFhizqGvVCSdpBIjeG
         uzx9TvwsjKuqwivNdQSrn+tEzUbSeIWMq3yMopHNYIeIEsUmjojFvTuL7oVOMImBnK
         Gje3y/t6OKjlU4Qj7oCY1nk3vUK7FAQVooJxH8t0uGVDIMwSMLci6q35qSXgB4Yw4m
         VZycCjHT+hb10tv615NNQsh8jMzNEYHSDGqNEw9+LIzlaBhXGr58gFcizpWeM1kUhX
         q3hW249ou4U2YVMgtekpx3v2D1LkUzOoFWZMNhIkKSGuby4sHzTfAeg0DL7YXxsRz/
         JHDL0faEzDBug==
Date:   Wed, 30 Mar 2022 11:18:43 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: use i2c_match_id and simple i2c probe
Message-ID: <YkQgc2rPbGYOcSBC@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220324165904.538861-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hozreqnn1jQnIoc+"
Content-Disposition: inline
In-Reply-To: <20220324165904.538861-1-steve@sk2.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hozreqnn1jQnIoc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static const struct i2c_device_id cdce925_id[];
> +

Instead of this declaration, I think we should move the
MODULE_DEVICE_TABLES up here.


--Hozreqnn1jQnIoc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEIHMACgkQFA3kzBSg
KbaAtw/+MbUtB2q/Iw3Bo0jpnt/Tscpb8p4CwVtnTWPAb49Pu2st/PvqGZ5wit92
0Si9Qyc9Ro9i5/auGIlfk1RGs2rPZx04nRFQuKU3cUWb8V0mZUueiGn9XdixNTYE
A2EVgoFtSYbTExLukYb3Cb0w7O2CUOiUutbDB2Tkzg+5TDQab8bn2J8Gbr0RZnIJ
FBxyFeyGd8wJ/o5QXMU4z9QtEzWfivyb33pe4IJNABfYJn0b+iPC5hDWEOrKIK2Z
tCPbDpc6yIk7yoPZqi0knaeDqticw7G2Tcx52pQChC7ahn9q/pNrxLeUdvaEJ6HL
m5sjcGXlxx2Ag9kwm1/AdXSnWuY0kvj3Gc+jbeva+9E5uhItsm0X09zD5ScG91Vv
aCcWPuoWcvhDB7p53PLuLXutjHwsuMAFMNHJ/8JTNb6oX5VSsk3juQtEWRaZ++lD
aIh3JR7imZW9sJlm+SSDFp+pun6hV8kUknskbjO24dU4HHo28Rx23JHc7RPOlgzC
yFNlUw4P7zxR90K2c880531IO/KFBRFZICQqjM3I6nUaE92nTGzKYNu6WxHfB0J9
exgPBOnMfx20ex6yb4j6p/ukoV3EnSAJorEQpS8DiQEgr+/cl7EnEPY3Da7upkvU
s7SWpOL5AVud+r/+ahqtSOqoy0xHwqxijQTkkJCCfOGgR7u7xgA=
=0xij
-----END PGP SIGNATURE-----

--Hozreqnn1jQnIoc+--
