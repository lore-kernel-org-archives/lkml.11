Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A29BC04A68
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 16:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiGZQgV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGZQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938312D28;
        Tue, 26 Jul 2022 09:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FB460D42;
        Tue, 26 Jul 2022 16:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281AC433C1;
        Tue, 26 Jul 2022 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658853377;
        bh=ble3zRDYs/yITk8HA/1pQokt6KnZTLpU07UlEohD6WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agTB7w/4rgu9pBobWKtUapMo9JBItfgWY/4f0gZVgL4KUFH7SQ/8mDIWSGd+qojE6
         EejuKRagYWctkrt0cddg9nPrE+QPp+YWPGMQXwtF2ZIva4jCjgErOLBPmRnJJNtoEA
         gmxDDuq1a2JWWHeuPxXrD35Jsclog4rG7q5bAK5/x9ww6eWbK0BwJPNUVciznbwZS1
         l6JI250Vb+ZqMU9Uct6FeRmGiHwWCslvvIwdGIYMYeYC8lPHESeS2jwDvnaH+dJRuN
         IZZiyDLQyrpy1sMGUiltK9Zv8nmqPbvWjlu6wcGzf/ySiBFktjJutwusNV8GOZLUbf
         rVmjIBUUM+Lnw==
Date:   Tue, 26 Jul 2022 22:06:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: mtk-hsdma: Fix typo 'the the' in
 comment
Message-ID: <YuAX/eR78JdSRCzS@matsya>
References: <20220721055647.46085-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055647.46085-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-07-22, 13:56, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.

Applied, thanks

-- 
~Vinod
