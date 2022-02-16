Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C615C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiBPXfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:35:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiBPXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:35:09 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FA2402D8;
        Wed, 16 Feb 2022 15:34:55 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A212D37D;
        Wed, 16 Feb 2022 23:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A212D37D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1645054495; bh=l6TOX4RGj73J9V8J3IdOnYYkTNyg/tJy5+JFjZxTByQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LD3hJngbVrU9ATV7KmPm8euh/WOIfjoORxt0EaIOWoo2F6aX4KETTwW6VmkCkiAU5
         KwCTzCuG8ldzTFcLp5ywz1x0b/PubiTcLbYijH2+cQBNU8aESlxf0MQ8zXw4RZLLbV
         iebJzSJaxTj/inBrsRwAXR2n4PKxKLk1vcCS42bt6hoV99tR3jtsIPoYxSEc5q+8oM
         tvGe1DzLbf5iwFFTDwJXx7AqZPSdOc1O97ywaeLsOWMvyj5hVtRwETcVWeou9Jczam
         FBldy/S/K3rrloUyeCTtl01p9z5ISimNNLCAt8IozZY46E9HNUkVT3+HW1xharI0Jz
         I/tsZWs55ITPQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
Cc:     Tomasz =?utf-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] scripts: kernel-doc: Move the TODOs
In-Reply-To: <20220104015946.529524-16-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
 <20220104015946.529524-16-tomasz.warniello@gmail.com>
Date:   Wed, 16 Feb 2022 16:34:55 -0700
Message-ID: <877d9u2xnk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com> writes:

> Earlier I thought I could take "add perldoc documentation" off
> of this list. Now I think it also means a self-documentation.
> And this is not even started.
>
> I'm putting this block by the end, where it can quietly evolve.
>
> * Transform documentation into POD (15/15)
> See step 1 for the series details.
>
> Signed-off-by: Tomasz Warnie=C5=82=C5=82o <tomasz.warniello@gmail.com>
> ---
>  scripts/kernel-doc | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index dd5801cad519..b9f381f0fc1b 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -53,10 +53,6 @@ See Documentation/doc-guide/kernel-doc.rst for the doc=
umentation comment syntax.
>=20=20
>  # more perldoc at the end of the file
>=20=20
> -# Still to do:
> -# 	- add perldoc documentation
> -# 	- Look more closely at some of the scarier bits :)
> -
>  ## init lots of data
>=20=20
>  my $errors =3D 0;
> @@ -2497,6 +2493,11 @@ Treat warnings as errors.
>=20=20
>  =3Dcut
>=20=20
> +TODO
> +
> +- add perldoc documentation
> +- Look more closely at some of the scarier bits :)
> +

I'm not convinced that there's any value in this bit of text, I'd just
take it out.

Thanks,

jon
