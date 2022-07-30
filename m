Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B6FC3F6B0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 03:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiG3DjL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbiG3DjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 23:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63D7E02A;
        Fri, 29 Jul 2022 20:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F92AB82305;
        Sat, 30 Jul 2022 03:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13EFC433D6;
        Sat, 30 Jul 2022 03:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659152343;
        bh=xVFNcytZRdMqagmPn8ufFMbBtglH3lVw4k5ZKLUkRX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tq0wpr6Pg4x34uavnm+sHfWQ58OolnUXWym7KbvOEYwtI7x+qiQW3udbkXazcQLFg
         vg0964KP013SCBR5uLKgVhS5U4zjk0QhyrtfvR8Q7KfYBlzZTdtF6N6AuzR6KiW8y/
         FA7BbMNmX37EsONegJ2K/IU/GjQDXxvg0ZU5dsMHapigqjBixUrkzAbM0M48q9cnna
         J+qKyuZ37U/vyj+RLl0wLxyF2m4reezFCMIrRakObXkWnoQM52HBFlDgntGWxSMa8y
         INUjDKWOv+uE+sbjRVrHRBfzUlUvHjbuKNmfyRVmXq0fQoFvqLPHxK9W6WJBS73JrV
         ++KXonL0co8QA==
Date:   Fri, 29 Jul 2022 20:38:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Naveen Mamindlapalli <naveenm@marvell.com>
Cc:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: Fix NIX_AF_TL3_TL2X_LINKX_CFG
 register configuration
Message-ID: <20220729203854.274f410a@kernel.org>
In-Reply-To: <20220728171026.22699-1-naveenm@marvell.com>
References: <20220728171026.22699-1-naveenm@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 22:40:26 +0530 Naveen Mamindlapalli wrote:
> Subject: [net PATCH] octeontx2-pf: Fix NIX_AF_TL3_TL2X_LINKX_CFG register configuration
> Date: Thu, 28 Jul 2022 22:40:26 +0530
> X-Mailer: git-send-email 2.16.5
> 
> This patch configures the NIX_AF_TL3_TL2X_LINKX_CFG register
> based on NIX_AF_PSE_CHANNEL_LEVEL BP_LEVEL value.

You need to explain what that does.

If it's a fix (assuming it is based on the tree in the subject) we need
a Fixes tag.
