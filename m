Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C477C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 03:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345583AbiHSDoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiHSDoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA854656;
        Thu, 18 Aug 2022 20:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58F261269;
        Fri, 19 Aug 2022 03:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8949C433D6;
        Fri, 19 Aug 2022 03:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660880650;
        bh=tQDiNfWzA21D60kFlMSBnQJgUJMFSLsPPtsCTArN8z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvg96v8yV+WkAwcFh3AbLCSHoY1VJdZLcPwgYwgM0tbTKrTuwaTpRqOeECmsiHCzP
         v5xXZ8vSlErD8nkhQ5mE/yTsEybVl32HWRr27E9fbSFYTQqRlfwotFB7H7Aho5/bJL
         mtZD+g5OLMseOU/9H/J4su16sjPAfEzi1ShmflPe4IC7HWwAnV4VxVx1fXaqJ9vPGc
         XidZMvuXSbLurTjC9rU5v6y/5XQoTcFSdz7g/+PC6FtZoGoMoloQ5FsOn1Wte0ePLM
         ekP+ZAQij4sSx+GpEsDeqbhW7cLJKRUXSWaTJpYsS4z2mpAgbcetDJPVJ1klhIGO49
         Mx9q9OSqLt4Mg==
Date:   Thu, 18 Aug 2022 20:44:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] net: sched: remove duplicate check of user
 rights in qdisc
Message-ID: <20220818204408.3fcb12a0@kernel.org>
In-Reply-To: <20220818072500.278410-1-shaozhengchao@huawei.com>
References: <20220818072500.278410-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 15:25:00 +0800 Zhengchao Shao wrote:
> -	if ((n->nlmsg_type != RTM_GETACTION) &&
> -	    !netlink_capable(skb, CAP_NET_ADMIN))
> -		return -EPERM;

This check is not network namespace capable, right?

We're probably fine making it namespace aware but it needs to be a
separate change.
