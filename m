Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD502C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 08:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiCJIcr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiCJIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:32:45 -0500
Received: from smtp.tom.com (smtprz01.163.net [106.3.154.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A52135701
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:31:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by vip-app02.163.net (Postfix) with ESMTP id 3C61A4400DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:31:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646901103; bh=tz98sccFxvbjWDJciH1zpeayD1ruRNaTozLwXtiPZlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDtPl7nlDBXpDKK7Tmv9S9bKH1hi6fJLWTYukCvzA+E9ohByiESJX3cA5wQ/aZ1WR
         KMjrovnVmKbPjxqzTSNX4mgzQL9MTvWR25Pf5chYaQTj5WT75u89Z/Mh2IB9V5TrkZ
         NUwJLqOVg7bze2NIZ6i6xUmvDKpqzQQBcyjorXzM=
Received: from localhost (HELO smtp.tom.com) ([127.0.0.1])
          by localhost (TOM SMTP Server) with SMTP ID 1269508722
          for <linux-kernel@vger.kernel.org>;
          Thu, 10 Mar 2022 16:31:43 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at mxtest.tom.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=mail;
        t=1646901103; bh=tz98sccFxvbjWDJciH1zpeayD1ruRNaTozLwXtiPZlo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDtPl7nlDBXpDKK7Tmv9S9bKH1hi6fJLWTYukCvzA+E9ohByiESJX3cA5wQ/aZ1WR
         KMjrovnVmKbPjxqzTSNX4mgzQL9MTvWR25Pf5chYaQTj5WT75u89Z/Mh2IB9V5TrkZ
         NUwJLqOVg7bze2NIZ6i6xUmvDKpqzQQBcyjorXzM=
Received: from localhost (unknown [101.93.196.13])
        by antispamvip.163.net (Postfix) with ESMTPA id 3BC62154153A;
        Thu, 10 Mar 2022 16:31:40 +0800 (CST)
Date:   Thu, 10 Mar 2022 16:31:39 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220310163139.00003d87@tom.com>
In-Reply-To: <20220310081908.GA26477@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
        <20220309061442.GA31316@lst.de>
        <20220309153136.000048e1@tom.com>
        <20220309212852.00007828@tom.com>
        <20220310081908.GA26477@lst.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 09:19:08 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Mar 09, 2022 at 09:41:59PM +0800, Mingbao Sun wrote:
> > So I tried with 'tcp_set_congestion_control'.
> > But then I found this symbol is not exported yet.
> > Then I applied =E2=80=98EXPORT_SYMBOL_GPL(tcp_set_congestion_control);=
=E2=80=99
> > in my local source, and it works well in the testing.
> >=20
> > Then what should I do with this? =20
>=20
> Add the export in a separate, clearly documented, patch, and Cc the
> netdev list and maintainers to get their opinion on all list.

Got it.
Will do that soon.
