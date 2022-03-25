Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD65C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiCYTrd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCYTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:47:23 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68407209A6E;
        Fri, 25 Mar 2022 12:29:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF6C2383;
        Fri, 25 Mar 2022 19:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF6C2383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1648236552; bh=OP5hn5ciXGl/PVl0o086b4VCHPgP+xHupbIU6ILJ9h0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VreuZEvd8t3BGJb+nqihUFltBrtweMvoVOlmMw4ZGzmyWE6yq/+dIoO5pvz1bF1Tg
         XTUGlGBaiEhsUfUZc3XYo8hmgBdRdolKNbkwPwU9TP+FBaFc858VsKWx+3S0qEm0KT
         AtxpjJYFQ4S4MKyP5BUZ5h7MaKpBCNpXFfdZSdrjGzbZNStkOep0H6V6sHDmtbM9nP
         gYc7GghsGKQu0rjUQCAOBg0cF0CpwTUKi7uMXhkPzfwYf0WuGwbV3wBrKt8Udo2pCd
         sA6sMrwcdfxEvd5Jq1Og198D/+Y+AtjdAx3NcQ/0J/MruEJSn2kAZ1osjFWMkhC0y4
         JwThMXOPQKZxg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Documentation: add missing page title for
 kernel-doc.rst and sphinx.rst
In-Reply-To: <20220322113645.502544-1-bagasdotme@gmail.com>
References: <20220322113645.502544-1-bagasdotme@gmail.com>
Date:   Fri, 25 Mar 2022 13:29:11 -0600
Message-ID: <87v8w1esqg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> sphinx.rst and kernel-doc.rst are missing page title, thus top-level
> headings in the respective documentation is displayed in the table of
> contents for doc-guide.
>
> Add the title.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 4 ++++
>  Documentation/doc-guide/sphinx.rst     | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index 79aaa55d6bcf2b..de47b20c806acf 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -1,3 +1,7 @@
> +==========================
> +kernel-doc Comments Format
> +==========================
> +
>  Writing kernel-doc comments
>  ===========================

Honestly, I think this is better fixed just by promoting the existing
heading up a level.  It describes the file nicely, and we don't need two
headers there.

> diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
> index bb36f18ae9ac3e..140507de5a85e0 100644
> --- a/Documentation/doc-guide/sphinx.rst
> +++ b/Documentation/doc-guide/sphinx.rst
> @@ -1,5 +1,9 @@
>  .. _sphinxdoc:
>  
> +=============
> +Sphinx Primer
> +=============
> +
>  Introduction
>  ============

Here, perhaps, replace "Introduction" with "Using Sphinx for kernel
documentation" or some such and make that the document title?

Thanks,

jon
