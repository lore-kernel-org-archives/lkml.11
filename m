Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F8C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 15:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiHQPyv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 11:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiHQPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:54:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD449C1F3;
        Wed, 17 Aug 2022 08:54:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12660B81E1B;
        Wed, 17 Aug 2022 15:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717E8C433D6;
        Wed, 17 Aug 2022 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660751670;
        bh=XukEBVzTzLJj1tOYCbdeMA5vBle0qiwfRadVpWY8xMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFgUbZKLQbqvJAE845SbZhDTVvhHmhQgtLhCfguEHhIYtM4T4ZgQh1M7ZmV47KF1o
         myvbbqXhQopL0AuHSaSEoA2kp/+XDXgIibsOyMTBzU3hATaezO14jCAlSQ8o78TuM8
         z6A8nbvqnKCXAgPNcCd9ohkd1rL3X04PMLelROp76hNzuknmlRORAGWufZRop6sj5v
         AjRiEffbGVwNsciRmbHJYY1Cislm0pufqN4WVZ2OGi1PQGr0w07ViPcqxhqYmzJrVI
         EhiDYCF5f39FjpS1H94KBG4wnE+rOwoe0cFA5tUEsVotNKky+vgD5zSISPDm3qZ441
         SWynHuhqTNPLg==
Date:   Wed, 17 Aug 2022 08:54:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     linux@armlinux.org.uk
Cc:     Beniamin Sandu <beniaminsandu@gmail.com>, andrew@lunn.ch,
        hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: use simplified HWMON_CHANNEL_INFO macro
Message-ID: <20220817085429.4f7e4aac@kernel.org>
In-Reply-To: <20220813204658.848372-1-beniaminsandu@gmail.com>
References: <20220813204658.848372-1-beniaminsandu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022 23:46:58 +0300 Beniamin Sandu wrote:
> This makes the code look cleaner and easier to read.

Last call for reviews..
