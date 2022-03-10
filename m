Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiCJPK4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 10:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiCJPKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:10:17 -0500
Received: from smtp.tom.com (smtprz02.163.net [106.3.154.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 860BA434B4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:03:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id D166C440111
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:03:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646924587; bh=UtpGvcZGJBtk6DfGPnrxi5oxMsyVQFjcoHXJFprouo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HiZoPcim0Y+9L13FJgW5rJDO/w3+b0LmluUBczB7TOziCK8UH4hJlBrHtS8ys5L50
         EPDBobuSyf4vWYyZL4RmGrWsG0FVVQEcA8PEKmnkoPF8HN7itRjY7noDiYVO/ffGWN
         w6T06jbvIsIfXInXX0bR02mtugLY/ykR64DtKvUc=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 325847902
          for <linux-kernel@vger.kernel.org>;
          Thu, 10 Mar 2022 23:03:07 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646924587; bh=UtpGvcZGJBtk6DfGPnrxi5oxMsyVQFjcoHXJFprouo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HiZoPcim0Y+9L13FJgW5rJDO/w3+b0LmluUBczB7TOziCK8UH4hJlBrHtS8ys5L50
         EPDBobuSyf4vWYyZL4RmGrWsG0FVVQEcA8PEKmnkoPF8HN7itRjY7noDiYVO/ffGWN
         w6T06jbvIsIfXInXX0bR02mtugLY/ykR64DtKvUc=
Received: from localhost (unknown [101.93.196.13])
        by antispamvip.163.net (Postfix) with ESMTPA id B4C3415414BB;
        Thu, 10 Mar 2022 23:03:01 +0800 (CST)
Date:   Thu, 10 Mar 2022 23:03:00 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tyler.sun@dell.com,
        ping.gan@dell.com, yanxiu.cai@dell.com, libin.zhang@dell.com,
        ao.sun@dell.com
Subject: Re: [PATCH] tcp: export symbol tcp_set_congestion_control
Message-ID: <20220310230300.00004612@tom.com>
In-Reply-To: <20220310141135.GA750@lst.de>
References: <20220310134830.130818-1-sunmingbao@tom.com>
        <20220310141135.GA750@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 15:11:35 +0100
Christoph Hellwig <hch@lst.de> wrote:

> Please submit this together with the actual user(s) in a series.
> Patches to just export random symbols are a no-go.

Got it.
many thanks for informing.

BTW:
could you give me the answer to the following questions?
1. Against which repo should I prepare and test this series of patches?
   netdev or nvme?

2. what's the recipients for this series of patches?
   netdev or nvme or both?
