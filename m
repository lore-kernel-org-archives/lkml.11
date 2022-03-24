Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B6CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 03:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiCXDTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 23:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241880AbiCXDTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 23:19:37 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C604DD6;
        Wed, 23 Mar 2022 20:18:04 -0700 (PDT)
Received: from [192.168.12.102] (unknown [159.196.94.94])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 255C82029E;
        Thu, 24 Mar 2022 11:17:56 +0800 (AWST)
Message-ID: <61ac01e70c293b7e0d378436f7617daaad552fcf.camel@codeconstruct.com.au>
Subject: Re: [PATCH v0] mctp: fix netdev reference bug
From:   Matt Johnston <matt@codeconstruct.com.au>
To:     Lin Ma <linma@zju.edu.cn>, jk@codeconstruct.com.au,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 24 Mar 2022 11:17:56 +0800
In-Reply-To: <20220324023904.7173-1-linma@zju.edu.cn>
References: <20220324023904.7173-1-linma@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin Ma,

On Thu, 2022-03-24 at 10:39 +0800, Lin Ma wrote:
> In extended addressing mode, function mctp_local_output() fetch netdev
> through dev_get_by_index_rcu, which won't increase netdev's reference
> counter. Hence, the reference may underflow when mctp_local_output calls
> dev_put(), results in possible use after free.
> 
> This patch adds dev_hold() to fix the reference bug.

This was already fixed in net-next to increment the refcount in
__mctp_dev_get() and use mctp_dev_put().

dc121c008491 ("mctp: make __mctp_dev_get() take a refcount hold")
e297db3eadd7 ("mctp: Fix incorrect netdev unref for extended addr")

Thanks,
Matt

