Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF3C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 17:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiCVRZW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiCVRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:25:18 -0400
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AC2983A;
        Tue, 22 Mar 2022 10:23:44 -0700 (PDT)
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 54B6341E2D; Tue, 22 Mar 2022 17:23:43 +0000 (UTC)
Date:   Tue, 22 Mar 2022 17:23:43 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Message-ID: <YjoGH2JYd7cvx844@rosenzweig.io>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-6-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +enum { APPLE_RTKIT_PWR_STATE_OFF = 0x00,
> +	APPLE_RTKIT_PWR_STATE_SLEEP = 0x01,
> +	APPLE_RTKIT_PWR_STATE_GATED = 0x02,
> +	APPLE_RTKIT_PWR_STATE_QUIESCED = 0x10,
> +	APPLE_RTKIT_PWR_STATE_ON = 0x20,
> +};

It would be great to get comments added explaining what these states
are. It's not obvious how off/sleep/gated/quiesced differ, and it's not
obvious from the code (doesn't look like GATED is used here at all?).
Are these Apple names or r/e'd names or a mix?

> +	if (!rtk->syslog_buffer.size) {
> +		rtk_warn(
> +			"received syslog message but syslog_buffer.size is zero");
> +		goto done;
> +	}
> +	if (!rtk->syslog_buffer.buffer && !rtk->syslog_buffer.iomem) {
> +		rtk_warn("received syslog message but no syslog_buffer.buffer or syslog_buffer.iomem");
> +		goto done;
> +	}

Nit: Wrapping is inconsistent between these two warns.
