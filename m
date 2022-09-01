Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8474CECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiIADwv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 23:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiIADwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:52:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78615110885;
        Wed, 31 Aug 2022 20:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53F35B823D5;
        Thu,  1 Sep 2022 03:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966FAC43142;
        Thu,  1 Sep 2022 03:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662004360;
        bh=BHttO8QfXSyZ6g+TqBZ87LlRBk5jhbe3ZdavxnFdxQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WR1xY7DQmVD/6O1j03y8V8rvuxh8c4o1HhdaCI8iiLVr39dHTFl1uTVvMcBTJ/DLX
         vorLzXMNnF239TCPtIGNCKzss2ERDddlNL4a+ICc4ryrDLldRukf6Ss2nRzjVX9XBd
         HyHHSTvZsb9tlvgsVCvHNU49mpfhFdHz0Wp4q5ztX4QGA+TSC4tdd7GKdFvbSaJEJ3
         xcf7Kp9caXX9YfT1e8hVTZc588GmXT/lbcjJyWRRNFp+oYj8xQz3GCQ81yQlFs8CiG
         keWsj1TnMV/abqQqOAe20ATISb6onCob/5YEufQbtVnXqY7+g6YyqWdcuMkY89My48
         vlIMRN67+YiXw==
Date:   Wed, 31 Aug 2022 20:52:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     wei.fang@nxp.com
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: add stop mode support for imx8
 platform
Message-ID: <20220831205239.7b8c559e@kernel.org>
In-Reply-To: <20220831080237.2073452-1-wei.fang@nxp.com>
References: <20220831080237.2073452-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 16:02:37 +0800 wei.fang@nxp.com wrote:
> The current driver support stop mode by calling machine api.
> The patch add dts support to set GPR register for stop request.
> 
> imx8mq enter stop/exit stop mode by setting GPR bit, which can
> be accessed by A core.
> imx8qm enter stop/exit stop mode by calling IMX_SC ipc APIs that
> communicate with M core ipc service, and the M core set the related
> GPR bit at last.

reportedly does not apply, please rebase and resend
