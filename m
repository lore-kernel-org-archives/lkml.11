Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 19:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiEYTQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbiEYTQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:16:19 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075911801
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:16:16 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l9-20020a5e8809000000b0065e534ca51dso9476157ioj.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zd7VaJ+t20Ip39Sfs4fMNAc8bfbYqGcyc9hWSuHpp9U=;
        b=ChZ+x9VArHJbisWK+TMd2BtfjpsRgRiJ0AV+plf6LVJyAvE/SBylCprGne6onq8wGF
         SyJ0oeFE/UXgGPUz07E9+u8hzVddtOeKweeK7mjfjIv2qKr/0JCad3AuBaH3MQTNElMS
         2A3v7ZMmPIZKjefHdOOvb+i5J0vC+WcubU5d6qZkNzwYum/JVStKFvsmbsgDKqcS8f1G
         ytCmBIoTQsLJhrTVnf5hwZ9UF2QJTNRALPjQOt2DRD08AFiPj8MbJTbtM2bkYu6ch9Q8
         NfCfW+vsIvePDHLGNqIYgQkLTTsT3OQ6b7gwKOLW/3Ysck8vZic0tvKw4ArgE+jqQVvS
         iRPQ==
X-Gm-Message-State: AOAM5303yPZ/B9FTe3T8qKUXIFxksUMu4/lwz5UI8k3SqWWNSI1Ghy3Y
        2pAfkxHK1lioiH5aK0nFym+nwySMwZLAFdHIa/YxWBI93PAF
X-Google-Smtp-Source: ABdhPJzxkK6efujxpBRrAJRPK4B+eeU7x8Paa5p6HD1Kw/H7xuz1ZqVcFs5pr1sQ1+srrNbm0lxfdajZhe18FVStIan97Too8PVI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc1:b0:2d1:8e35:dcba with SMTP id
 x1-20020a056e021bc100b002d18e35dcbamr11361659ilv.58.1653506175646; Wed, 25
 May 2022 12:16:15 -0700 (PDT)
Date:   Wed, 25 May 2022 12:16:15 -0700
In-Reply-To: <0000000000009962dc05d7a6b27f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bc05a05dfdae88b@google.com>
Subject: Re: [syzbot] WARNING in mroute_clean_tables
From:   syzbot <syzbot+a7c030a05218db921de5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, erdnetdev@gmail.com,
        eric.dumazet@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
ipmr,ip6mr: acquire RTNL before calling ip[6]mr_free_table()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
