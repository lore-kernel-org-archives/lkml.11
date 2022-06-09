Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiFINKh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbiFINK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:10:26 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99BED8E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:10:25 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61FBF40002;
        Thu,  9 Jun 2022 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654780224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXXb6P9Cvl1Zw0pt22LdE638pd3NE17nBJYMk4WRUpQ=;
        b=hq7VmEw3j/yIDUeup7m471TiSKlOzA2mlV5ZB2IjEsMBVyRSRy5nezwp7rwoma8nmsp0jC
        WYfDmg70dhurrG05jWfEuBhIIQwbMev9XxYiSRtWdGI7jzFdTb0JG1gecrPgqE895Y2t+h
        rU4ru4yMyjam2qD44gyxEER3yVd6M74hKMoYA/DVbzw8zt6jFrsV7YsSobXHMLi/vPkgtA
        2dxcgzf/MEmUzzyp/kyzPgfFcQBQU35vKWh5dIUtDBk0By4ZTZIfI3ViIEYuLM3oLfp4ir
        H2Hkan5nLKW5zmpO29afrG1HGwPuvLWlqFmhZnp6ndMdsG0IUz8WaJjMalpZ8g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtdchar: prevent integer overflow in a safety check
Date:   Thu,  9 Jun 2022 15:10:22 +0200
Message-Id: <20220609131022.293516-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516070601.11428-2-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a1eda864c04cf24ea1130334963c6199318f6f95'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-16 at 07:06:00 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> Commit 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE
> ioctl") added a safety check to mtdchar_write_ioctl() which attempts to
> ensure that the write request sent by user space does not extend beyond
> the MTD device's size.  However, that check contains an addition of two
> struct mtd_write_req fields, 'start' and 'len', both of which are u64
> variables.  The result of that addition can overflow, allowing the
> safety check to be bypassed.
> 
> The arguably simplest fix - changing the data types of the relevant
> struct mtd_write_req fields - is not feasible as it would break user
> space.
> 
> Fix by making mtdchar_write_ioctl() truncate the value provided by user
> space in the 'len' field of struct mtd_write_req, so that only the lower
> 32 bits of that field are used, preventing the overflow.
> 
> While the 'ooblen' field of struct mtd_write_req is not currently used
> in any similarly flawed safety check, also truncate it to 32 bits, for
> consistency with the 'len' field and with other MTD routines handling
> OOB data.
> 
> Update include/uapi/mtd/mtd-abi.h accordingly.
> 
> Suggested-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
