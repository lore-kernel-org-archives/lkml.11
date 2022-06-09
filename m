Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390DBC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 12:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbiFIMoO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbiFIMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:44:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3274A3E9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:44:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 349DE1C000D;
        Thu,  9 Jun 2022 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rh0EyhjuDEt34kf2NyApfB4/YmN6/yaxANbey6hLXEM=;
        b=RhSngzTJO64S6lbii9KYjY6QfSmkrIxa/gQlLBWM+AZbYqCnJy8iz+R8kQiJl7PSKwPK+R
        8SnKfoh9agj1iA3qV282RjCouMmX4VjIJdB50wX6Qy8UwqFqbphTJ8ro3GM9//YQHH1qfh
        yyE4kjoyOYhUmJ6aJ2lvvQvQ5xsyvsVhfMF2Pn8CyFq6hjeVBMKOvAUyurTk87wZ9gW8sG
        WRDELfDn5JNa7WlzkHDfWULJgDoUFB1K6YomsOGa1W4JGrU0t3E+ciorcEJ+mHhoQ1EUb0
        XC1ZSxgcmIaw8J7VGkrD7jr2h4ObCjiB6mI6K7r49Yph7bUZNaxQ5y2Ac5V2Gg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: Add support for ATO25D1GA
Date:   Thu,  9 Jun 2022 14:44:08 +0200
Message-Id: <20220609124408.209175-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220604113250.4745-1-aidanmacdonald.0x0@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'fc602b4f692cb83c937b5f79628bca32b60c4402'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-04 at 11:32:50 UTC, Aidan MacDonald wrote:
> Add support for the ATO25D1GA SPI NAND flash.
> 
> Datasheet:
> - https://atta.szlcsc.com/upload/public/pdf/source/20191212/C469320_04599D67B03B078044EB65FF5AEDDDE9.pdf
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
