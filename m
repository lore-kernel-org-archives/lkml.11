Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EECC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 16:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiFPQE0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiFPQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:04:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FD29C85;
        Thu, 16 Jun 2022 09:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E92EC60DBB;
        Thu, 16 Jun 2022 16:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44116C34114;
        Thu, 16 Jun 2022 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655395459;
        bh=JO1HKRHKxu7WPx4qEiPzXk5d2zmhZIc2D4Xy7QgyiF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAFkbaIUC20fFE5GCcvpoVmvmbSEA6WSMh2h3yqpAZDE0NQ3LBFxa7vTFy3kWPrLO
         WIgy/BU6jxpWtmHuRnNfFCeg+Sl/l4sU19T0vWG6T9ObRnVRUCbbRoW2ObJvXTMnIQ
         vRTCu0s8M64Ev0hCFHaEEFaAzyNiY95k2VN7HVH/myMefuTb+IYGZYb6KoDFgj0kny
         A8wYG6wVvsjsa0m3BdNi0m5uAE1U8B78/lNGfGabovaoxnD20JmvFPg69p8hGhxQP7
         dJCsiq1pBi6sXDN3SICmhmLmbX1b7uqIFII7tzw9WXZjuL7/xu51uFEi0gtDDESmwP
         ph107cKjXreYg==
Date:   Thu, 16 Jun 2022 09:04:18 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] dmaengine: stm32-mdma: Remove dead code in
 stm32_mdma_irq_handler()
Message-ID: <YqtUgrNQphUjJpvu@matsya>
References: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655072638-9103-1-git-send-email-khoroshilov@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-06-22, 01:23, Alexey Khoroshilov wrote:
> Local variable chan is initialized by an address of element of chan array
> that is part of stm32_mdma_device struct, so it does not make sense to
> compare chan with NULL.

Applied, thanks

-- 
~Vinod
