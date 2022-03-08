Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 15:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347851AbiCHPhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 10:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344633AbiCHPhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:37:32 -0500
Received: from smtp.tom.com (smtprz14.163.net [106.3.154.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D54E3A9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:36:35 -0800 (PST)
Received: from my-app02.tom.com (my-app02.tom.com [127.0.0.1])
        by freemail02.tom.com (Postfix) with ESMTP id 40842B00DB6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:33 +0800 (CST)
Received: from my-app02.tom.com (HELO smtp.tom.com) ([127.0.0.1])
          by my-app02 (TOM SMTP Server) with SMTP ID -306153361
          for <linux-kernel@vger.kernel.org>;
          Tue, 08 Mar 2022 23:36:33 +0800 (CST)
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail02.tom.com (Postfix) with ESMTP id 1EBD3B00D97
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
        t=1646753793; bh=0ZR9FwH3D+exTqdROkMCZNENmTbneHFVfFxZ1ZHcdXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XbUmTMRyRMAQYszw8qyLiBY/HOSNNdwnEOSFnqa10oUbT6Jz7GVaj/r5R8MVVtrDj
         DE9md4idj3V0nifUPr53mkw00FSPmRD//o+NmFqmo8GGGgi68M/7mVJMm09i1644TB
         sc1/qppcFweRd4gT086ZJX0tkwc7q3jw2YdW83uw=
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id ED97DD415B6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4F98t_ae8QOW for <linux-kernel@vger.kernel.org>;
        Tue,  8 Mar 2022 23:36:31 +0800 (CST)
Received: from localhost (unknown [101.93.196.13])
        by antispam1.tom.com (Postfix) with ESMTPA id 85940D4155C;
        Tue,  8 Mar 2022 23:36:28 +0800 (CST)
Date:   Tue, 8 Mar 2022 23:36:27 +0800
From:   Mingbao Sun <sunmingbao@tom.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tyler.sun@dell.com, ping.gan@dell.com, yanxiu.cai@dell.com,
        libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the
 congestion-control
Message-ID: <20220308233627.0000727d@tom.com>
In-Reply-To: <20220308151606.2563-1-sunmingbao@tom.com>
References: <20220308151606.2563-1-sunmingbao@tom.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per the comments from Christoph Hellwig, the calls to networking APIs
in nvme-fabrics.ko were deleted.

Since the tcp_congestion passed in from the user-space could also get
checked later within sock_common_setsockopt in nvme_tcp_alloc_queue.
So this deletion brings no downside to command 'nvme connect'.
