Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7362AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Mar 2022 04:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241942AbiCSEop (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Mar 2022 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241916AbiCSEok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 00:44:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126A2FE70;
        Fri, 18 Mar 2022 21:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3949AB82541;
        Sat, 19 Mar 2022 04:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C4C340EC;
        Sat, 19 Mar 2022 04:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647664996;
        bh=R1WowPSirZfIAglWFtE0PFmlANmB1qcEBJSDl8RumPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lyGcXEc2UU4wC42fBvcZusoS6ja6g15nHic8fTIv/hKYe5tKAXfw49UWGHwNbiTWs
         cNTOkhqfMFncpZWADkmdFUPfnHLH5K8k6CvV+M8eV2kyEjf9nSDQ+ESqsQNuHHzd8+
         MleFx17gZswQR6rMM7mPNJnfPpF+kDQkmj3z99xduIH8tg6JSm0xFZ4p0Naz92h8Ni
         ZxRSh3Hgh8WQqYNgYGSp8FZpWGC28GxMDZDrfNaaKoywmD/5Sivkl298Rp2HhT/zFH
         6VmXvyAla4qUcPpw/LXDEDvHSKwiIbK5yDO8NWQGMVRMo5JQ2jCLl6fMtyzMIeuX2V
         +V2QnKZbat+Bg==
Date:   Fri, 18 Mar 2022 21:43:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     <borisp@nvidia.com>, <john.fastabend@gmail.com>,
        <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] net/tls: some optimizations for tls
Message-ID: <20220318214315.31278755@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <cover.1647658604.git.william.xuanziyang@huawei.com>
References: <cover.1647658604.git.william.xuanziyang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 11:13:34 +0800 Ziyang Xuan wrote:
> Do some small optimizations for tls, including jump instructions
> optimization, and judgement processes optimization.

Acked-by: Jakub Kicinski <kuba@kernel.org>
