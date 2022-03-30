Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B962C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 02:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiC3Cyq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbiC3Cym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:54:42 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924C17F3FC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso13627739ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=QTWd4i/NLWNwVTetwl9CtbJr/No1iCLKabQJftIK/JA=;
        b=qVXLUVNA59SCG7ZposA91CL0jLnHpdVL2Ds6pxwXkZ815XBYVZ9QX4CUdy6zO+10KZ
         7I+GSswkxjmxHsA2KUaIXUwHOdbcyvfOsTmc68zq0UtnPjqdjOEBcwixDF0G4gVSWcAy
         nD8WRBBiJCp/NrTCEQEij4gEHgUlqPe5exec/ZED2tuluIcMa/sEv/cWJudo6Ha0rNdy
         KjjJfRDiWBoG28hsSSSyHUSPlhOIYhYeNOR1a2a4ev4+9d5R6LprDTyIvTnAsEPa2bdB
         1VXbD6tKiZXiDSEM9GdjxRVR8jFsZPfNpVU1wEtlwYydvO6ZH82KAHTSORbf6rcW/BcM
         ahdw==
X-Gm-Message-State: AOAM531Lr6aZ3qaH01DLDdgdVLNUMNziOnndutN/lxQsD4RfVrlJ5jOV
        CbdZJWCO7NFBfIUiLmy0KQhrDKwoafwoSc1Mvj7x/C16fJQr
X-Google-Smtp-Source: ABdhPJyq9cQJoYCYrKX1O1yqGx4xWLqI4SbSujkC+1zs14yfWnJqdT9ztdF8dPSAxYZS5ZRJPB7UCGp5tHB/P7vcWu8eb6aUgH5Y
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id
 u3-20020a056638304300b003147ce24a6emr17819523jak.258.1648608777933; Tue, 29
 Mar 2022 19:52:57 -0700 (PDT)
Date:   Tue, 29 Mar 2022 19:52:57 -0700
In-Reply-To: <CAFj5m9+Gc-t6vD17yWBNos-fk9vmhUTLsXYGrSx4Bdzn7R67JQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009518f205db66a47a@google.com>
Subject: Re: [syzbot] possible deadlock in throtl_pending_timer_fn
From:   syzbot <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Mar 30, 2022 at 5:23 AM syzbot
> <syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    cb7cbaae7fd9 Merge tag 'drm-next-2022-03-25' of git://anon..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17ef8b43700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7094767cefc58fb9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=934ebb67352c8a490bf3
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+934ebb67352c8a490bf3@syzkaller.appspotmail.com
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

This crash does not have a reproducer. I cannot test it.

> for-5.18/block
>
> It should be fixed by:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.18/block&id=d578c770c85233af592e54537f93f3831bde7e9a
>
> Thanks,
>
