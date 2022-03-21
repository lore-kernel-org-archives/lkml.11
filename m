Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 08:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbiCUI7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345573AbiCUI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:58:41 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8679D13F8FE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:57:10 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f11-20020a056602070b00b00645d08010fcso10084980iox.15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=NcMsyQOizIg+FSP6Uckb8XV/GuwoJGkZ5lgxRR+GvL0=;
        b=tgykBhZ+bkBItwqKqZvlihPr+FXHxfmJHcABpVnm73NFQvWpiqxPMaowJ2Mlf8PEDX
         CbjWzUm+jG83/NgnovcrdyRWjf4DKCW/wO+ZAYFmZjfdB2dK1pdFpoGPRQ5JVuMETY1s
         ZAbVPkNyteIJWV07AeOeamdyEVbW+AUxsGw2uEdre4XsIvLBOKpdYBYNVegPAXtw55o6
         IColhtpd+pvsxwjJmGpgTNE0aFS8mnykS4dRKi5CeH6kmACxFTVizYjFaR4Jon+Kf64C
         IAowihZzgaiyHRwe1H5SxSc/Yo645arwbGljGKsQuJltTHC14UIKameRS2eXYMb2r8wb
         GzmQ==
X-Gm-Message-State: AOAM5311Co3ChVfQwhGUoFc89SVGUKqDP8TypC5H6kTm8jYhR+hfr0YG
        G3+MIUXIVfaY4BUQFVPpJby68b3uH/rHoCejHIXzNV4/80jN
X-Google-Smtp-Source: ABdhPJxsJo7EtKQKDpLRy2c3jQP2ezpg/1oDEPRmoJSRvSNOSDhiZotVQa4B0wU9hn+zeCTiGBKJGdLdNh2ucjrpS4xP67t9TlFA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c1:b0:319:a36f:4120 with SMTP id
 n1-20020a05663831c100b00319a36f4120mr10274214jav.81.1647853029932; Mon, 21
 Mar 2022 01:57:09 -0700 (PDT)
Date:   Mon, 21 Mar 2022 01:57:09 -0700
In-Reply-To: <978188.1647853022@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007dc40905dab6aed5@google.com>
Subject: Re: [syzbot] WARNING in __do_kernel_fault (2)
From:   syzbot <syzbot+ce865a1a714eca006986@syzkaller.appspotmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     christophe.jaillet@wanadoo.fr, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git 6d39b096627f0a1eb6e14f049d8ae3c93e0290f2

This crash does not have a reproducer. I cannot test it.

>
