Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiBOF20 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:28:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBOF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2541160E9;
        Mon, 14 Feb 2022 21:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69ECB6142A;
        Tue, 15 Feb 2022 05:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E205EC340EC;
        Tue, 15 Feb 2022 05:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644902894;
        bh=FMP6hhzenKGVJK2994yCbpnQWl6c4Hn3Cho4XmuGtLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmUjK3yeyIlNUAnLQNZRD4BmYj88GLKTrPRYzi1q1n3X2CM9UAtam+ujXLK168bBq
         WV+yhLVAL65D5U5mSlU/UAlJi8vTTS+5zW14xIJmZ3mE83h64x9vp0MH7Xk5FFdOIh
         rAfYUDr+eMx0cx8R8Qoe4irMM6tiIXmDwcUv9gStjN6JvIxr+jiMI+HPxZ1hDt/Or9
         MhzGCs5V/wZ8WQcIvHqu8JtAft9GowqpBuvKqxlmzJ6/fsmpDE7IJ2sQLrFpfLPhfn
         ZmbEMkXyycxNrY/5oHNoyF2aiG2mt8w8V20px/OTmVRnrfsPL8UHE5GHPWqMIrtM+S
         SteXdIzbkSMKg==
Date:   Tue, 15 Feb 2022 10:58:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dmamux: Fix PM disable depth imbalance
 in stm32_dmamux_probe
Message-ID: <Ygs56gKv4VDNjBnZ@matsya>
References: <20220108085336.11992-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108085336.11992-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-22, 08:53, Miaoqian Lin wrote:
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().

Applied, thanks

-- 
~Vinod
