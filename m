Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E6C25B0E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 03:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiHQDDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiHQDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3859242;
        Tue, 16 Aug 2022 20:03:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20FF461472;
        Wed, 17 Aug 2022 03:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA7C433C1;
        Wed, 17 Aug 2022 03:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660705419;
        bh=j34Y0IvnP4PIUZa4lmiS/njGfPbOT1P5mPXfCn2SqXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LJwB5PyM7KRn9sh6SHSyW+E4p9BqquodqZlA6nZ89lvX7aSi/Sg/NQC88ep/TYGS8
         FkNFs6AROYzWcFi75c+xXZhemebqAQOtFp6thpwtwQxLfJhQWpowc9H9cE9ZBgdlvd
         e/+zbDZrV9JnD4r8ytHLoLW9E63iUrD1o5AiOShEXjHLbOaSLDvVS47LIksKIrIn/I
         tpc0b9inuJrj+IY7m8BdRbOWNudJ2YOMHQcer4NvQR7ci/yQjZTje4fXYY+tSNSYS0
         odxGREHH1lYy46PDL9R9F4OtJDwPoxI+qkgNoEVdEjA+B+/bpHndj4+HuWUhUcnxRr
         qWcFcyB3HY8fw==
Date:   Tue, 16 Aug 2022 20:03:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vee Khee Wong <veekhee@apple.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        tee.min.tan@linux.intel.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 1/1] stmmac: intel: remove unused 'has_crossts' flag
Message-ID: <20220816200337.35befaad@kernel.org>
In-Reply-To: <4C6D4699-3BC3-4F31-86E2-B5CD7410CC0A@apple.com>
References: <4C6D4699-3BC3-4F31-86E2-B5CD7410CC0A@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 15:30:07 +0800 Vee Khee Wong wrote:
> The 'has_crossts' flag was not used anywhere in the stmmac driver,
> removing it from both header file and dwmac-intel driver.
> 
> Signed-off-by: Wong Vee Khee <veekhee@apple.com>

Your MUA corrupted the patch, it stripped the leading spaces.
Can you resend with git send-email ?
