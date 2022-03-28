Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCF1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Mar 2022 15:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiC1Ppf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiC1Pp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:45:29 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81B4888A;
        Mon, 28 Mar 2022 08:43:48 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1648482226; bh=JCpqMHJ6otYgfj2zSfXB9RBHyVtJRWFIKxZQ4Fk3YvI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XgTSl9cvKEL5rwjrGQY4S32YWBWp8Iqjd/z/0ehjHwdD2AxisgQxeITwsWiX+I/4Z
         zL2PJtSiqPD/ituh8X/SnMhDZHiGha6c3ha9J9fMV4cLXp+Z/RATrWRn/LhB7Agcjm
         qGW4Fi5WJjAPi9Ah9zz1ZQHuwYuwnNwtmcQG62l4a8yg8AkN4sql3AdUAFUowCQ60F
         b39Zg2FDEZffGWiqyGui3JKNcXVKAVmFoMzhn7A9zRrN9wxZeg2mCWgyzJjWIRJZaT
         ayyw6GR9BZsouydytE7ZNruFHXfvbcSr+KqvsvEMOhIStdD1sPN0DmPiDGmdxiBpNb
         VXJLG47mw36rw==
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        cake@lists.bufferbloat.net
Subject: Re: [PATCH net-next] sch_cake: Take into account guideline
 DEF/DGSIC/36 from French Administration
In-Reply-To: <356a242a964fabbdf876a18c7640eb6ead6d0e6b.1648468695.git.christophe.leroy@csgroup.eu>
References: <356a242a964fabbdf876a18c7640eb6ead6d0e6b.1648468695.git.christophe.leroy@csgroup.eu>
Date:   Mon, 28 Mar 2022 17:43:46 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bkxq5bgt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> French Administration has written a guideline that defines additional
> DSCP values for use in its networks.

Huh, that's interesting!

> Add new CAKE diffserv tables to take those new values into account
> and add CONFIG_NET_SCH_CAKE_DGSIC to select those tables instead of
> the default ones.

...however I don't think we should be including something this
special-purpose into the qdisc kernel code, and certainly we shouldn't
have a config option that changes the meaning of the existing diffserv
keywords!

Rather, this is something that is best specified from userspace; and in
fact Cake already has no less than two different ways to do this: the
'fwmark' option, and setting the skb->priority field. Have you tried
using those?

-Toke
