Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbiC1K2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiC1K1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E6C36E02;
        Mon, 28 Mar 2022 03:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3DE60FCC;
        Mon, 28 Mar 2022 10:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81A5C004DD;
        Mon, 28 Mar 2022 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648463168;
        bh=ClrbOWRSNMLl96m+NhBGm3Qrgj7yVuAq3b+4WcQ0rAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jb8eKOJTOMzxbajxJGkA9vxuWFcssjok0OoiizOjXmuFfGDzcYGBmPKnzFcMUWeJG
         YB7gQT8IR29Ze0+2NdPi4vN2mEDvLJD90RzrTM3JWWCpvf598luRcWob/I/SnLLRxd
         xV/SiWwv4kDhkYP0sQ2vLrxfR9CSCo+DuUiQg9JR3MkYpbkVnQS0vbSlcneZhnY8f6
         0cFvYTTM8QtK0GZQRZ3JxZh1c56T3T9ed44RUPmAMxus5RJNA7PoAX0ieqCvLytqdp
         sGLPZUfJJxrRnIdKJdJu8mI4u7i3SBLjH52W2sl30XcRdbFkvDCGD6H05rGeA23A9a
         y0WxUfg7zoNRg==
Date:   Mon, 28 Mar 2022 12:26:04 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kfigure.py: Don't warn of missing PDF converter
 in 'make htmldocs'
Message-ID: <20220328122604.67d0eb5e@coco.lan>
In-Reply-To: <c80e1481-10d4-7151-fe59-e846259eb0d4@gmail.com>
References: <c80e1481-10d4-7151-fe59-e846259eb0d4@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 26 Mar 2022 16:48:39 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> SVG -> PDF conversion is not required in "make htmldocs".
> It is pointless to always warn of a missing converter.
> Demote the log message in setupTools() to verbose.
> 
> For "make pdfdocs" (or "make latexdocs"), promote the dynamic
> message of "include SVG raw" to a warn.
> Expand the message and recommend installing Inkscape or
> ImageMagick.
> 
> Fixes: 8ccd05697a9d ("docs: sphinx/kfigure.py: Use inkscape(1) for SVG -> PDF conversion")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-doc@vger.kernel.org

Makes sense to me.

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  Documentation/sphinx/kfigure.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
> index 24d2b2addcce..cefdbb7e7523 100644
> --- a/Documentation/sphinx/kfigure.py
> +++ b/Documentation/sphinx/kfigure.py
> @@ -212,7 +212,7 @@ def setupTools(app):
>          if convert_cmd:
>              kernellog.verbose(app, "use convert(1) from: " + convert_cmd)
>          else:
> -            kernellog.warn(app,
> +            kernellog.verbose(app,
>                  "Neither inkscape(1) nor convert(1) found.\n"
>                  "For SVG to PDF conversion, "
>                  "install either Inkscape (https://inkscape.org/) (preferred) or\n"
> @@ -296,8 +296,10 @@ def convert_image(img_node, translator, src_fname=None):
>  
>          if translator.builder.format == 'latex':
>              if not inkscape_cmd and convert_cmd is None:
> -                kernellog.verbose(app,
> -                                  "no SVG to PDF conversion available / include SVG raw.")
> +                kernellog.warn(app,
> +                                  "no SVG to PDF conversion available / include SVG raw."
> +                                  "\nIncluding large raw SVGs can cause xelatex error."
> +                                  "\nInstall Inkscape (preferred) or ImageMagick.")
>                  img_node.replace_self(file2literal(src_fname))
>              else:
>                  dst_fname = path.join(translator.builder.outdir, fname + '.pdf')
> 
> base-commit: 8d6451b9a51b555be2c9a6c326a980b2de00741a



Thanks,
Mauro
