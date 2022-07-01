Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2BCC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 11:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiGALrs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiGALrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:47:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4683F18;
        Fri,  1 Jul 2022 04:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31F40CE3172;
        Fri,  1 Jul 2022 11:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E883BC3411E;
        Fri,  1 Jul 2022 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656676062;
        bh=zHN7lUkv5PsDpZQbhvOzUH17PWAirh032lFbPs15u8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojUP+jQJkMu/bAD4b/Fko5MzgbamLPUAz7rk1VcKKWunJAqKfoGf4WsoJ5JI8KR1y
         ZgINc98MK9fct4zXdNJN50T1pK14fcPhRUB7gvtvAiyNrPmtOx5YTQSqceEx4NN5EO
         zm1bDWuZEQwHiZ7jX4z2sZhbnQDpdKaLg9BMtrt5vNYzJ36Lb6pa98t0yr8oTGKpvm
         tFJqAu2cHVqcQNdmtmMNsbGxW4uY9rjW8o7gFSbcUeLwph2M5qo83g1d0bUoIZ8pyO
         cXlF/PfJ+OzOcOvnW9cnPkHvm1HzcXLLAbyEKVyfBwLouWkgY0Ssm1lStYQxIzwuom
         eiMhiNQwRjTEg==
Date:   Fri, 1 Jul 2022 17:17:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     dmaengine@vger.kernel.org, peter.ujfalusi@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721s2: Add psil threads for sa2ul
Message-ID: <Yr7e2uA2PqfpdI/7@matsya>
References: <20220628050232.331956-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628050232.331956-1-j-choudhary@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-22, 10:32, Jayesh Choudhary wrote:
> Add endpoint configuration for the four ingress and two egress
> threads for main domain crypto accelerator.

Applied, thanks

-- 
~Vinod
