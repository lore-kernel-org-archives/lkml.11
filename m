Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1ADC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 06:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiGDGUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiGDGUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2460EA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:20:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5AA5614B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99034C341CA;
        Mon,  4 Jul 2022 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656915617;
        bh=A4h5GbEBxWOrFEgxeNla7JtQHAIQ1C3ga5hbZfT2dCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tY0CRepkAq0a+vv2aJ/9UFVk3r/+tC0Bpag74VMvcIecMHRFoKKuESUTAfI60XGWK
         fi5+Ula+V8dD7O2hOvL4EEB1a2Zqe1SkvxuZ8vVvb/YOO2qEKh3ohNNCYq2XOSnRt4
         XA9Q5FwC/jZFfRM5dKFFd09S3YHVO3QSeCm+TImtre8Cmre2DBquv+hID+8lP4HRUt
         AZNiNqTkGcJZ8vXxWtrBSvrQN6R5vn4xb4Upfqu1JHbqCQJC4ZZZVqIPDCwmNr9V3h
         p3EMruv0P8yzcHua73rZO4gYWbUGIQp75o3KAApPmdnPYDSCa0/yK69qd9lTMmyeep
         yLRd8fBqCE0rw==
Date:   Mon, 4 Jul 2022 11:50:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus_type: fix remove and shutdown support
Message-ID: <YsKGnWXdX5OJ2JXU@matsya>
References: <20220610015105.25987-1-yung-chuan.liao@linux.intel.com>
 <YrQca7YH8v6XCl02@matsya>
 <a861f3b2-dec4-982d-0939-1dfc18dd2f53@linux.intel.com>
 <YsJ97kNAmz7U+42m@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsJ97kNAmz7U+42m@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 11:13, Vinod Koul wrote:
> On 23-06-22, 09:54, Pierre-Louis Bossart wrote:

> I see that dev_pm_domain_detach() is called unconditionally and not
> dependent on remove method which seems right to me.
> 
> The code seems same since 9251345dca24b

And I overlooked the setting of method, which is correct, sorry for the
noise.

Have applied this now, thanks

-- 
~Vinod
