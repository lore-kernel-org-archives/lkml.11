Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A6BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 08:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiBHIjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiBHIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:39:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6116C03FEC0;
        Tue,  8 Feb 2022 00:39:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5140F60B4F;
        Tue,  8 Feb 2022 08:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FCC340ED;
        Tue,  8 Feb 2022 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644309550;
        bh=4jQ04LjZfUbQzPTvU2cT4/8kmd6n6kvE/jSKStVXFjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVYmo7kf1a9CWGEgO70gZ9N6EZp49iQTYs7VBhPvWfFNwHC6Dee2Lp9UOBSmoEwMD
         GISIrFwH3fq0jQ5ZnET0x+Ben/ClgGnZh1/mLYUTZlDXDclJbH3QKo6HwmlJGSIVwJ
         N7rGu0p4EFeR6wzvKXrJLi5JXsGMV0xsAaDBBqDY=
Date:   Tue, 8 Feb 2022 09:39:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        stable@vger.kernel.org, sfr@canb.auug.org.au,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mtd: rawnand: protect access to rawnand devices while
 in suspend
Message-ID: <YgIsK+eGr6pqHQhQ@kroah.com>
References: <20220208082507.1837764-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208082507.1837764-1-sean@geanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:06AM +0100, Sean Nyekjaer wrote:
> Prevent rawnend access while in a suspended state.
> 
> Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> rawnand layer to return errors rather than waiting in a blocking wait.
> 
> Tested on a iMX6ULL.
> 
> Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
> Follow-up on discussion in:
> https://lkml.org/lkml/2021/10/4/41
> https://lkml.org/lkml/2021/10/11/435
> https://lkml.org/lkml/2021/10/20/184
> https://lkml.org/lkml/2021/10/25/288
> https://lkml.org/lkml/2021/10/26/55
> https://lkml.org/lkml/2021/11/2/352

Please use lore.kernel.org links, we have no control over lkml.org and
it does not work with our tools at all.

Also:

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
