Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7E4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 00:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiDAAR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 20:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243331AbiDAARX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:17:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B38419B2;
        Thu, 31 Mar 2022 17:15:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1na4wt-0004YP-NS; Fri, 01 Apr 2022 02:15:32 +0200
Date:   Fri, 1 Apr 2022 02:15:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jaco Kroon <jaco@uls.co.za>, Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Subject: Re: linux 5.17.1 disregarding ACK values resulting in stalled TCP
 connections
Message-ID: <20220401001531.GB9545@breakpoint.cc>
References: <CADVnQyn=A9EuTwxe-Bd9qgD24PLQ02YQy0_b7YWZj4_rqhWRVA@mail.gmail.com>
 <eaf54cab-f852-1499-95e2-958af8be7085@uls.co.za>
 <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
 <10c1e561-8f01-784f-c4f4-a7c551de0644@uls.co.za>
 <CADVnQynf8f7SUtZ8iQi-fACYLpAyLqDKQVYKN-mkEgVtFUTVXQ@mail.gmail.com>
 <e0bc0c7f-5e47-ddb7-8e24-ad5fb750e876@uls.co.za>
 <CANn89i+Dqtrm-7oW+D6EY+nVPhRH07GXzDXt93WgzxZ1y9_tJA@mail.gmail.com>
 <CADVnQyn=VfcqGgWXO_9h6QTkMn5ZxPbNRTnMFAxwQzKpMRvH3A@mail.gmail.com>
 <5f1bbeb2-efe4-0b10-bc76-37eff30ea905@uls.co.za>
 <CANn89i+KsjGUppc3D8KLa4XUd-dzS3A+yDxbv2bRkDEkziS1qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+KsjGUppc3D8KLa4XUd-dzS3A+yDxbv2bRkDEkziS1qw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <edumazet@google.com> wrote:
> Next step would be to attempt removing _all_ firewalls, especially not
> common setups like yours.
> 
> conntrack had a bug preventing TFO deployment for a while, because
> many boxes kept buggy kernel versions for years.
> 
> 356d7d88e088687b6578ca64601b0a2c9d145296 netfilter: nf_conntrack: fix
> tcp_in_window for Fast Open

Jaco could also try with
net.netfilter.nf_conntrack_tcp_be_liberal=1

and, if that helps, with liberal=0 and
sysctl net.netfilter.nf_conntrack_log_invalid=6

(check dmesg/syslog/nflog).
