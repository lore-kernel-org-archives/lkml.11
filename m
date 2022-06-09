Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D48C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 12:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiFIMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343553AbiFIMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:43:11 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47043527E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:43:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 138A1FF809;
        Thu,  9 Jun 2022 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nh1UKK3uyNrH1iUfVE+joZpnh8MNcC8j9ct+8ypJk6k=;
        b=VkTw0SskS0M+TzRZihBsjVCjSeIzjHkS/C9SS1ZaqAkVbS08Pcoe3q0mFI3p2v3fZk+ycb
        F6n6ClM4/EoVcRDErsK4sLyMAHM8n1wbKogIVO1jPBzr24macRRuhoaVgpMTKWt8L8gDDZ
        shFiW6eE5LOVkePyW11D0LDJWirnuoHehhQNQ7H339YHNjwF7Bt1GcjdLMu8sqlWFmxJG4
        a1fQWnBOtixmCS1FQoTkzkEsoGTIq64YANYLs8dWdwcB9IViJfBccFiM3ZIlralVafHPjD
        slnJn44xdUFRPsvWf8giArI5kFYMREhq0fXptZn47eTgF7DdJCbNe0xRk/C+Bw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: Fix refcount leak in of_flash_probe_versatile
Date:   Thu,  9 Jun 2022 14:43:02 +0200
Message-Id: <20220609124302.133097-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523140205.48625-1-linmq006@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'33ec82a6d2b119938f26e5c8040ed5d92378eb54'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 14:02:05 UTC, Miaoqian Lin wrote:
> of_find_matching_node_and_match() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: b0afd44bc192 ("mtd: physmap_of: add a hook for Versatile write protection")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
