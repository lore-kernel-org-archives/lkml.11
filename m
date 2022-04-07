Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C963C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbiDGRsa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDGRs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:48:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44911271E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFDCE61976
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B19C385A0;
        Thu,  7 Apr 2022 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649353584;
        bh=Jkvw4HbUD+BJnLkGElMbJBIW0lO8m3RLntyqyhk1X6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnvq4cgiesiEk+CxUkH5lrwhvijZrGWqmipS+cWYZvnVo/Y5obLg9uWlLpO9garDW
         fQUzdePrQCXQ2o1uh+FN7JU7S0Nu3lIfF3n3IdRlTwnoU0DgxkPBJQWVqjWhc0YzgB
         s1bwgCOckxYLVk+zyMDQXxyCGYvS1zC7tGPL7aJE=
Date:   Thu, 7 Apr 2022 19:46:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8712: remove unnecessary parentheses
Message-ID: <Yk8jbTSjvsHXpX2U@kroah.com>
References: <20220407125947.8525-1-eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407125947.8525-1-eng.alaamohamedsoliman.am@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 02:59:47PM +0200, Alaa Mohamed wrote:
> Reported by checkpatch:
> 
> Remove unnecessary parentheses around structure field references
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
> Changes in v2:
> 	- Edit commit subject
> 	- Edit commit message
> 	- Fix the same check in more lines
> 	- Remove space before '.skey' in
> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86.
> ---
> Changes in v3:
> 	return the space before '.skey' in
> "memcpy(psta->tkiptxmickey.skey," in lines 84 and 86
> ---
> Changes in v4:
> 	edit commit message to be clearer.
> ---

Why did you send this patch twice?

