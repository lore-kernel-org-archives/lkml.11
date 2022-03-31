Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2553AC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 15:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiCaPsy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbiCaPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:48:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274A3A9;
        Thu, 31 Mar 2022 08:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 173FDB81B7F;
        Thu, 31 Mar 2022 15:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40105C340ED;
        Thu, 31 Mar 2022 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648741609;
        bh=hiwngJ/tEvf+cZOHAUZeS2nj7bIbpDJdxWUISWNpTvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d0yDW+1fCXEfQzsqgq0cpK6YiiVHyxtDuZp07VQD+Ukdh/dw7K0S3YtyO9/FkoqSQ
         su39AWF9ntRt5wI5UKlJ+VIOljQZtFyacZAgVH/kDzBfkN9Aa7NoqNCM7lE1zJ8tap
         KI8aHdxEMzjIc2NnAfOVqki+q4y4geHApCqdiezeLbpB2H2xmtwQEYE+FJtFcHvbjU
         yDXUmtQ+viC+KbE66nc6o8dAC7DuGXVde5Taa4/NNrUW6ft45wSY2ILoSHMa2Lxa0X
         wPSQxVlhWGCbdRqcRM/gdLubfalVcF2nR/TT9nEeI5IMK40rPjpfXKSbXtrAtkAbDs
         qAzxfJ1BZeq/A==
Date:   Thu, 31 Mar 2022 08:46:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: xilinx: use of_property_read_bool()
 instead of of_get_property
Message-ID: <20220331084647.679aaaa5@kernel.org>
In-Reply-To: <1648728535-37436-1-git-send-email-wangqing@vivo.com>
References: <1648728535-37436-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 05:08:55 -0700 Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> "little-endian" has no specific content, use more helper function
> of_property_read_bool() instead of of_get_property()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

# Form letter - net-next is closed

We have already sent the networking pull request for 5.18
and therefore net-next is closed for new drivers, features,
code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after 5.18-rc1 is cut.

RFC patches sent for review only are obviously welcome at any time.
