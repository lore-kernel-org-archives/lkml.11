Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C04C00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiHJLQj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA36CD19;
        Wed, 10 Aug 2022 04:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D2A6120C;
        Wed, 10 Aug 2022 11:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15101C433D6;
        Wed, 10 Aug 2022 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660130191;
        bh=gX0B7NeBF2fjqE7R6DLYopWVKMMwSFPgZzJvJBXPVJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcBSt5uT9rz/Ry5LlfLlC+0vpFL+ycjKeyQJ5sZIzTMchjj4kaynrmwJxIDqKloDl
         lPxU6sz1gF2zW5x9Q2wxcPzmK7Xredy3nIvrkjoy87i/xzMmJyGhv4ni7s02wNnucZ
         pRB+/JEZVd5Q+7RhyGGnl9wCC03dHkdz91mOBLYIMsqTWjgmdVFDQ9PZpQVwrRYwno
         U93UiQ1UhLahtPo0X0Nd9xD56csS7YTtdW9HmNHk1Gk7XVlXiIr77ZMemmiaGwSJvJ
         GBN9SQkZBmHH0xOCvjiCJ2dZ2VY8KfCVQbbPNqq5vMRltcuYjIHoA8r11utsgJ9JvH
         AN/+wV+/JdLYA==
Date:   Wed, 10 Aug 2022 12:16:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, Milo Kim <Milo.Kim@ti.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: lp8788: Fix an error handling path in
 lp8788_probe()
Message-ID: <YvOTim7i2hhW2cWF@google.com>
References: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18398722da9df9490722d853e4797350189ae79b.1659261275.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022, Christophe JAILLET wrote:

> Should an error occurs in mfd_add_devices(), some resources need to be
> released, as already done in the .remove() function.
> 
> Add an error handling path and a lp8788_irq_exit() call to undo a previous
> lp8788_irq_init().
> 
> Fixes: eea6b7cc53aa ("mfd: Add lp8788 mfd driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/lp8788.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
