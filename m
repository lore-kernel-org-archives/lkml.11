Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 05:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbiEXFKT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 01:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiEXFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:10:13 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2E52534
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:10:12 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k17-20020a5d9d51000000b006653f2bc513so2166776iok.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RLdathxNRDtG5L+EHBxBN5npKUIaJok/neVijABbchA=;
        b=vJSfjkDOhGaNSquUf9LY5ubTpeduc1/7xN8H5VAAeG5bMgxD8Aeake+TiDE58UInXz
         PdOLZhP0SMw1ifo0+FCTR7wPyE9UJu7pmcaWAT/Mwi4GiRqfzWHqr1EPVlLV0o7EuVJA
         d3xcYhWZwdbZ4gWdQjQRj/WDJ5Yy12Ht5/S3dI7xGv8drERTnJFs0NDVVPYBiQ5iOyfO
         YbcB13QAUYOYfH2QVHtgm4tIN6NcLQSYrxNWFOxCkxfx5NmZUcFvyKdazpyRjGFV8zBW
         kWA7ahA1k0me81X0Ntq6dS3u3fYKRVEzn3tVMSZxTOFxApNwPRULDlSHuuUWJziAh/1R
         Duug==
X-Gm-Message-State: AOAM532L4JjOoSjbTeCRnqiN8k6DOuJXT1gWEKorguXtNhwKvvVYTzpY
        TCvEiUGR855ygb8dG3Jxd2SwCpiVecfc/yNMJRiLwsaksvX6
X-Google-Smtp-Source: ABdhPJzznskfzf9VBAV1ruLrVAjMDKoPPsbCzHgrw+TaH+F5gFesVkRdD/AvojTK6qKyZV/9oIlz+TjKfbhOqHDW9XufBVMh0gGV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1182:b0:32e:5c70:c89c with SMTP id
 f2-20020a056638118200b0032e5c70c89cmr12844921jas.45.1653369012254; Mon, 23
 May 2022 22:10:12 -0700 (PDT)
Date:   Mon, 23 May 2022 22:10:12 -0700
In-Reply-To: <20220524044832.3351-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8803205dfbaf813@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in udf_close_lvid
From:   syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/udf/super.c:113:7: error: no member named 'impUse' in 'logicalVolIntegrityDesc'
fs/udf/super.c:121:57: error: no member named 'impUse' in 'struct logicalVolIntegrityDesc'


Tested on:

commit:         143a6252 Merge tag 'arm64-upstream' of git://git.kerne..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ff0355f00000

