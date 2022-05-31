Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48324C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 22:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiEaWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 18:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348491AbiEaWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:35:06 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8389E9DD;
        Tue, 31 May 2022 15:35:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A2B06F0;
        Wed,  1 Jun 2022 00:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654036503;
        bh=5wGWNsYpV/rqdoGt8KcWqJ6na3ftVpXTTaFU84KJud4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZMOsUcvBCXrCDZqZ5Vk1HZDEdCWQw5wJ6lkzg1wtZYwojhkvHDDKh/qS7rn6/Zqg
         zlK9FjcoON8eLj0Uwfs8G9mHHrgs3/uKt3QaUV2tRqTY3GkWu+gbxn0bAHaDWWs8dM
         bKm4Bwkbv6eWBtO1b5YwCZPZRLs6WPlTAJMlM/8k=
Date:   Wed, 1 Jun 2022 01:34:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree-fixes
 tree
Message-ID: <YpaYEtWSEyD7WKCU@pendragon.ideasonboard.com>
References: <20220601082959.2fefa1e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601082959.2fefa1e7@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:29:59AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   adb97f9f8442 ("dt-bindings: soc: imx8mp-media-blk-ctrl: Fix DT example")
> 
> Fixes tag
> 
>   Fixes: 584d6dd668e2 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 8b3dd27bfe47 ("dt-bindings: soc: Add i.MX8MP media block control DT bindings")

My bad, that's the correct SHA1.

-- 
Regards,

Laurent Pinchart
