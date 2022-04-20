Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377938AbiDTLLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 07:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377919AbiDTLLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F44130F;
        Wed, 20 Apr 2022 04:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947D3618BF;
        Wed, 20 Apr 2022 11:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BEBC385A0;
        Wed, 20 Apr 2022 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650452912;
        bh=N++B1ixndLylwVAxJVTe2Bdtd3hERPgELEY77Y8zsKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=is+SqCaQxkh8AuYNcb9yRKUv1ZjoyKoPkHv6zYNXjQktb2IRCmcRXQpwF8MftaysD
         2NtiHOKBaOQho9HOnQ1E72ZhAb6C+YbpfAtYQJQREVu7kJBPPk1n0MQWFhYlUv9Nbs
         n3dPUUEM8DpW9FjIM4s0NWALUwGiqy3NuJeEbHy7S84ykiXMrW0cvnvv8mdLlBw94k
         2afG3NBEmNX4oCmeAERAqAUpVlcEE2iCRhyWtFZNkv7r0wKkLp1zvtXbEp+hnuew3i
         Jl+KZhJSPXJeFWO1/V6EJvZk05w7xuXzSfrfyvqQAPVKhwlg+SfbPoglTwfpvEc0+8
         jikY9CGSf6PiA==
Date:   Wed, 20 Apr 2022 16:38:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     i.m.novikov@yadro.com
Cc:     sanju.mehta@amd.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH] dmaengine: PTDMA: support polled mode
Message-ID: <Yl/pq7+Kd0cPucAP@matsya>
References: <20220413113733.59041-1-i.m.novikov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413113733.59041-1-i.m.novikov@yadro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-22, 14:37, i.m.novikov@yadro.com wrote:
> From: Ilya Novikov <i.m.novikov@yadro.com>
> 
> If the DMA_PREP_INTERRUPT flag is not provided, run in polled mode,
> which significantly improves IOPS: more than twice on chunks < 4K.

Applied, thanks

-- 
~Vinod
