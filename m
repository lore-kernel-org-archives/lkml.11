Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF542C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352679AbiEQT2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEQT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:28:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4D5046B;
        Tue, 17 May 2022 12:27:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C179A2ED;
        Tue, 17 May 2022 19:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C179A2ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652815678; bh=/QzBE1g3FDUveDZep0WhdgVTjtDbJx6LIIH7y88Rjyg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cj15ruyVLknmP2PklVx+SA+wLZbz+wm3OnA8eaUHkpmYcYtdOKGors2xmsBzuqiBt
         si95mKBRRt8D92DQpm7NTOH7tbyI9pG+pnMOV5ANBSVxZpvUokq5YUSZtWsuRcrjY7
         TAGP81xNGktgPfw2Q6qiT3VPNnNqLAklFck1n/rFese9KR5QoHUfow6Qze4zT0ms4u
         TqgsofH10kb+awNWnGjaTdp78UiD9DW0z8ZpX+JgpBE0iPbVi6zrMPjHieMLGT0N0h
         6NUkM1Ti21IfR46hCVtigDT9gCLu9e8kgXzu1Br6rGJU4TQqJtvQda2r7M7M+aCEM+
         ozL9qA876g8Hw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yanteng Si <siyanteng@loongson.cn>, alexs@kernel.org,
        seakeel@gmail.com, bobwxc@email.cn, tangyeechou@gmail.com
Cc:     Yanteng Si <siyanteng@loongson.cn>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng01@gmail.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Become the docs/zh_CN maintainer
In-Reply-To: <b0c1324d1d63846d700ab354446a6deaf30754c0.1652712771.git.siyanteng@loongson.cn>
References: <cover.1652712771.git.siyanteng@loongson.cn>
 <b0c1324d1d63846d700ab354446a6deaf30754c0.1652712771.git.siyanteng@loongson.cn>
Date:   Tue, 17 May 2022 13:27:58 -0600
Message-ID: <8735h8vu0x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yanteng Si <siyanteng@loongson.cn> writes:

> It's time to become a maintainer of Chinese documentation, and Yanteng's plan
> is to help everyone with the utmost enthusiasm and patience.
>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ce78f2275dc..ff1364d9f7cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4649,6 +4649,7 @@ F:	Documentation/dev-tools/checkpatch.rst
>  
>  CHINESE DOCUMENTATION
>  M:	Alex Shi <alexs@kernel.org>
> +M:	Yanteng Si <siyanteng@loongson.cn>
>  S:	Maintained
>  F:	Documentation/translations/zh_CN/

I've applied this.  I am curious, though: what is your sense for what
being designated a "maintainer" means?  Do you envision something beyond
reviewing patches (for which an "R:" entry would be most appropriate)?

In any case, you help with the documentation is appreciated!

Thanks,

jon

P.S. There is normally no need to send a new version of a patch just to
pick up a tag; b4 makes that just work.
