Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 05:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGFFfZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 01:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGFFfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 01:35:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CB2181C;
        Tue,  5 Jul 2022 22:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27BA4CE1E29;
        Wed,  6 Jul 2022 05:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90109C3411C;
        Wed,  6 Jul 2022 05:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657085710;
        bh=WAJQav4CJxb3BLVSymvhfwAW87uYuArozZLP8kv7s5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luJ+SWW58ynOE3bqUEdvVisZVkiXb7eNWybghbQD701HESskzz5wWZNkbmXZG24iO
         h/7H1wbA21xmaCHtYYfhQjy72cRzKCZFJbu4yR/Ar26TAS5k8jGab/kf/WtAJE02oJ
         FRzd3K1ryGyEfpJ/YIdbpAj4q7aFm+Jc2ZWl78YT9PB4Ai7Im6RPwCfFNRTXjWOkpp
         hf8QUg9XtAUF0kQB+69Zk5AiGwFwxW3/w/XY/0A85asMkB1fmnRXkgew1N99lxShjR
         vOanOecW7YDL4KHacbD/d9iy5Q1mk7xJ8DnwxMJpQeM8oIX82A0TSA8zKDWtnyb8L7
         2+8WnGR+uxULA==
Date:   Wed, 6 Jul 2022 11:05:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: use strscpy to replace strlcpy
Message-ID: <YsUfCaN6KknEAbtd@matsya>
References: <12e4cf06.a35.180fa748c29.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e4cf06.a35.180fa748c29.Coremail.chenxuebing@jari.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-22, 17:03, XueBing Chen wrote:
> 
> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.

Applied, thanks

-- 
~Vinod
