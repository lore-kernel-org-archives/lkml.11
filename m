Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 17:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiFBRok (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiFBRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:44:38 -0400
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907DE2B12C0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:44:35 -0700 (PDT)
Received: by rosenzweig.io (Postfix, from userid 1000)
        id A0CEB4000C; Thu,  2 Jun 2022 17:44:34 +0000 (UTC)
Date:   Thu, 2 Jun 2022 17:44:34 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add ARM/APPLE MACHINE mailing list
Message-ID: <Ypj3Aps1e5h2qTHx@rosenzweig.io>
References: <20220602173144.2263-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602173144.2263-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Thu, Jun 02, 2022 at 07:31:44PM +0200, Sven Peter wrote:
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55114e73de26..621eeb037a91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,6 +1826,7 @@ ARM/APPLE MACHINE SUPPORT
>  M:	Hector Martin <marcan@marcan.st>
>  M:	Sven Peter <sven@svenpeter.dev>
>  R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
> +L:	asahi@lists.linux.dev
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  W:	https://asahilinux.org
> -- 
> 2.25.1
> 
