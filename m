Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE01C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 18:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiF3SWt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiF3SWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:22:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09AE427C3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:22:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3485B4B7;
        Thu, 30 Jun 2022 18:22:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3485B4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656613351; bh=v2AD2eIXL4iNJqkrF6cRoa/wR4S3ugL94KsEmipCAdA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rs2dKKZa2PTpXEtmJx+NaHzzMHffZd29wirjZ+oFeviMqXemXSKkU9yf2VFr8+Uoi
         hZphaPRSA/J+ePDgOPc9jJKfqUpeLkTxDFBAne99rhQRkAjlklIw8tFwn3gjxENOH+
         uPRHmArJ4wgU3RPXZ9pSG0NNcvMqp/2So7y+8EdeR7Jw18pPA8zNSyhpNc7gk5+KDi
         KLHpF5lppzAuoq7ciq6cMu9jN3rBBIqbdZQS3MpKLDnJAcKhhaUVVLT3EMGe9CkDGy
         4mKDY1ux8ozqADlRY3y5UxRDNlMXZ30zv3y/vU0pqO8tlFSM9YB5HgpT7ICPIroFat
         W++Xw5t+avQig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Reaver <me@davidreaver.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Reaver <me@davidreaver.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: get_feat.pl: use /usr/bin/env to find perl
In-Reply-To: <20220625211548.1200198-1-me@davidreaver.com>
References: <20220625211548.1200198-1-me@davidreaver.com>
Date:   Thu, 30 Jun 2022 12:22:30 -0600
Message-ID: <87h742nh95.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Reaver <me@davidreaver.com> writes:

> I tried running `make pdfdocs` on NixOS, but it failed because
> get_feat.pl uses a shebang line with /usr/bin/perl, and that file path
> doesn't exist on NixOS. Using the more portable /usr/bin/env perl fixes
> the problem.
>
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>  scripts/get_feat.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
> index 76cfb96b59b6..5c5397eeb237 100755
> --- a/scripts/get_feat.pl
> +++ b/scripts/get_feat.pl
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl
>  # SPDX-License-Identifier: GPL-2.0

Applied, thanks.

jon
