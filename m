Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 03:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbiGNDma (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiGNDm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:42:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684EF2124D;
        Wed, 13 Jul 2022 20:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E1062CE24A3;
        Thu, 14 Jul 2022 03:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F51C34115;
        Thu, 14 Jul 2022 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657770142;
        bh=OrvBccMSR2X7nBQCDDbMH6Xr05TMrt2n9YeysFTvblM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mXkSjw0ls1Zs1ArCL0tjVhY0NV8/5l1OcxM+T0QKZYMBqrAdoGzPE7zsfcuY3JQit
         KyYafjwc7CcFN+jZ6ul165QtlrVbQjdKmorT5RfU3jSotfi3McJ9/zws7peCvyUwms
         0WwaW+oBvtoTyUlSFaDl+EFRTwREee4jHAHljfaTgToSTKJpos789seusV5qZJhofU
         uVlZ5aPhKEfccpAGuq8whPCEQl5sgJndww6xNVOMQsHfeEn7oCsOE7T12GgBN9xhL1
         61ngj6+e4NT589eqQRyq0mAiDSC09+gfuVnmqQfdm0n1Bfqy5JFLyOy+1XouT5G3Ka
         UbHGwGlAPAVgQ==
Date:   Wed, 13 Jul 2022 20:42:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     iamwjia@163.com
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajur@chelsio.com
Subject: Re: [PATCH -next] cxgb4: cleanup double word in comment
Message-ID: <20220713204220.45cf3904@kernel.org>
In-Reply-To: <20220713150934.49166-1-iamwjia@163.com>
References: <20220713150934.49166-1-iamwjia@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 23:09:34 +0800 iamwjia@163.com wrote:
> From: Wang Jia <iamwjia@163.com>
> 
> Remove the second 'to'.
> 
> Fixes: c6e0d91464da2 ("cxgb4vf: Add T4 Virtual Function Scatter-Gather Engine DMA code")
> Fixes: b5e281ab5a96e ("cxgb4: when max_tx_rate is 0 disable tx rate limiting")

Please drop the Fixes tags, it's a cleanup not a fix.
