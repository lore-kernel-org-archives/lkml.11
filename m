Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1368DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 06:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiDQGjU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiDQGjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:39:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607712AE0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 718CC61143
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32987C385A7;
        Sun, 17 Apr 2022 06:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650177403;
        bh=aKPWGRM5VxIJbLEEY2sSyVOljL1D5DvxjWI3i4feUsk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Y9fEW42431wvmXRjjiq7WeGPbtOVd8lv8BFB02h74F55FlGG+csvnrG2rbnOczo29
         ziuGmuxxr/HU7Ips5wNEACwVS9PsKRBK4tx/MVenRg9QUCfJBtJlXW60OP9eOluB7v
         8t6h705R7PwnYEDS30wX3QT9z2s6FACqWXwFtkgZaKg3KYicZuuRaM0YDpJUvtP6pX
         31FKC1tMmJD9i2p2A9S8gDzFOGEbSfMLpGhhpdEMaDi8IkcmuOj14JFbeF/aXQkobF
         1qVoPe3UljXDSuCJtIM/pYOejshS5JuKRHcMs+uLT4eYNbhxmzeEAqakO943Ztfyuj
         q/Sqc43FnChmw==
Message-ID: <38535431-906e-a61d-4feb-156df9585bdf@kernel.org>
Date:   Sun, 17 Apr 2022 14:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix wrong condition check when
 failing metapage read
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220411212141.1775589-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220411212141.1775589-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 5:21, Jaegeuk Kim wrote:
> This patch fixes wrong initialization.
> 
> Fixes: 50c63009f6ab ("f2fs: avoid an infinite loop in f2fs_sync_dirty_inodes")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
