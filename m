Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7346C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 20:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381952AbiDTUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381910AbiDTUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:07:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F0D3E5F6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:04:29 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C57D322249;
        Wed, 20 Apr 2022 22:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650485068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVlyUurUeccWOLgMm4v3rPEY6etdKUNqiNzwxQaQMf4=;
        b=M6w8k/8NUhAjoB0cqnf3hyKnltF7o6ip1/PoNtWtZh3fS6dsWL1rjcP3yknMgErHOoDyug
        a8zlwX3uQF46LO0c4XwNsoVIvtc777gOc3E0TAUGllPSX32wFpH3dDPmBW/l3/XcBY5dsD
        2pk8nAfODH0GZDDXM9LTt9u65qMxE4E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Apr 2022 22:04:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Takahiro.Kuwano@infineon.com
Subject: Re: [PATCH v4 10/11] mtd: spi-nor: spansion: Remove status polling on
 volatile registers write
In-Reply-To: <20220420103427.47867-11-tudor.ambarus@microchip.com>
References: <20220420103427.47867-1-tudor.ambarus@microchip.com>
 <20220420103427.47867-11-tudor.ambarus@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <fe64ff3024456bd3584e1c3e748bd9a1@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-20 12:34, schrieb Tudor Ambarus:
> Writing volatile registers are instant according to Cypress and do not
> need any status polling. Remove status polling on volatile registers 
> write.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Michael Walle <michael@walle.cc>
