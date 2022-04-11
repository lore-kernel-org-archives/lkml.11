Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1C3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 08:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiDKJBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiDKJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:01:47 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5925C4F;
        Mon, 11 Apr 2022 01:59:31 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 762EA100010;
        Mon, 11 Apr 2022 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHhGfgxL0S3jJMjJ9eWRoGXgfDat53Md5h9pfpllbBk=;
        b=hUgcWSpQ8LygWqNmSFSaYQ/9wS/ZhdbQ/KhyoVXhioGge6FYFMWgsvU2FVjaONpYB9+QV7
        q8Mq0VmJwvQ0Tvy3h8ylFoszzMx3LV0iCZg8o05/YUCVTBjx4PLqxpuqJbfRQNEagkvX5e
        e46VxrinOS09rppBS7bBLTnmzV/EhhPnQSvJvvn5DxP+Avcnw/HSC4yOozsn8GyuMuu1U/
        znMEsTEGTfc6ZAQ/B5q1xr0PQ1n8VtzVrleov4c5yZ0elX56U2IUtbXG9BTHV1DRwIj4fF
        ViyOLILWIidJS1ZRdBP37G4D9DdYFVAHsHfp5SZWdkzj7kEPCi/Gn+KrRjJnfA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?utf-8?b?UmFmYcWCIE1p?= =?utf-8?b?xYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: add driver handling U-Boot environment variables
Date:   Mon, 11 Apr 2022 10:59:26 +0200
Message-Id: <20220411085926.10925-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406143225.28107-2-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'06a39b4da6de04315c133eaca4c785ae6ebc930f'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 14:32:25 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot stores its setup as environment variables. It's a list of
> key-value pairs stored on flash device with a custom header.
> 
> This commit adds an NVMEM driver that:
> 1. Provides NVMEM access to environment vars binary data
> 2. Extracts variables as NVMEM cells
> 
> It can be used for:
> 1. Accessing env variables from user-space
> 2. Reading NVMEM cells by Linux drivers
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
