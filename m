Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC18C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 01:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiCNBfo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiCNBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:35:42 -0400
Received: from smtp.tom.com (smtprz01.163.net [106.3.154.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E026725C68
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:34:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id 54C224400C6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:34:32 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1647221672; bh=tCwCTuNV8vbPzPftdhc6YfcqI53uXHjpEfLiz8JtAFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OtkTDZQB7oHyH2BgY2VnloBqnhOYt1Kp/0jAGjVujhMThs97WIUA5D+HpR21FJ6Qf
         wySmuuq/pld+/LxuUlW3eIdAdWGt6diH7YC7/Ngc7X6FqY7K2kWdJ3zEFKpVAgN3ml
         S35tZb17hrUsQmUBbsEg0egvFXxF8c5Lt622WvSg=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 1531590502
          for <linux-kernel@vger.kernel.org>;
          Mon, 14 Mar 2022 09:34:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1647221672; bh=tCwCTuNV8vbPzPftdhc6YfcqI53uXHjpEfLiz8JtAFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OtkTDZQB7oHyH2BgY2VnloBqnhOYt1Kp/0jAGjVujhMThs97WIUA5D+HpR21FJ6Qf
         wySmuuq/pld+/LxuUlW3eIdAdWGt6diH7YC7/Ngc7X6FqY7K2kWdJ3zEFKpVAgN3ml
         S35tZb17hrUsQmUBbsEg0egvFXxF8c5Lt622WvSg=
Received: from localhost (unknown [101.93.196.13])
        by antispamvip.163.net (Postfix) with ESMTPA id 96EAA154146C;
        Mon, 14 Mar 2022 09:34:29 +0800 (CST)
Date:   Mon, 14 Mar 2022 09:34:29 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/3] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220314093429.00005b95@tom.com>
In-Reply-To: <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
References: <20220311103414.8255-1-sunmingbao@tom.com>
        <20220311103414.8255-2-sunmingbao@tom.com>
        <7121e4be-0e25-dd5f-9d29-0fb02cdbe8de@grimberg.me>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before answering the questions, I=E2=80=99d like to address the motivation
behind this patchset.

You know, InfiniBand/RoCE provides NVMe-oF a lossless network
environment (that is zero packet loss), which is a great advantage
to performance.

In contrast, 'TCP/IP + ethernet' is often used as a lossy network
environment (packet dropping often occurs).=20
And once packet dropping occurs, timeout-retransmission would be
triggered. But once timeout-retransmission was triggered, bandwidth
would drop to 0 all of a sudden. This is great damage to performance.

So although NVMe/TCP may have a bandwidth competitive to that of
NVMe/RDMA, but the packet dropping of the former is a flaw to
its performance.

However, with the combination of the following conditions, NVMe/TCP
can become much more competitive to NVMe/RDMA in the data center.

  - Ethernet NICs supporting QoS configuration (support mapping TOS/DSCP
    in IP header into priority, supporting adjusting buffer size of each
    priority, support PFC)

  - Ethernet Switches supporting ECN marking, supporting adjusting
    buffer size of each priority.

  - NVMe/TCP supports specifying the tos for its TCP traffic
    (already implemented)

  - NVMe/TCP supports specifying dctcp as the congestion-control of its
    TCP sockets (the work of this feature)

So this feature is the last item from the software aspect to form up the
above combination.
