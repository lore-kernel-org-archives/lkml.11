Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 13:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbiBKNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 08:24:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiBKNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:24:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE378BBF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:24:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w20so4661271plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=f0Fqv0bzjFszIvvUAYWw2+6kT8bby7TTzSPdzg4sLUk=;
        b=Nc1J7qQsJ5lN0gl2mCSiyQbwLxaid+TjM4CKQxk6Cf5vjQ6gi9mrnWc6LNrSc7aWqO
         AZSCN78OBiJa5L4N6lszjiBB+TZ+S1dlkQsQcMU6dpYy4yIiUF09ZrZH9oNotc1ekUlx
         3iVYoiIAcrxfOrvi9ICK74/BPk3R3gJE864ANAv2SdLvyOZkoUlDrXFN3DlO6nKkx4DS
         jP3aWbXY8gcefvSLNxVKFJslqMJ5KY4eDFk3q0yQT2Gr3y67Yf02Uq2oWTEa2w2y35gy
         oyKEBdp4yD9CCmAzoamDdHaNBaRuK4XO2G+KGLiiwKA0bVThIv207BqyzRuR6Mm6YT/3
         ez1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f0Fqv0bzjFszIvvUAYWw2+6kT8bby7TTzSPdzg4sLUk=;
        b=TOlWMtzC3STq4R6TrurdQprtbe49oXu4xwazDHEhsQ7hnVVrOp8wPHe6q5IcgJPmNz
         PakibtVRIjHzR0AMObqwsxMjzkvEm3DuSrqsyxxWa8y5MOiJtnaUVpUZRThrgyZFDYtR
         d2aNu/33vXOs9pnYH9FvQ0qW3YGD3zpypeBcaQ163FDxwDnAicf7EQ2RpuyPSP/M5/pi
         ft4Q2lRtBAG6Wts+9//8NPdIOBK+zeI0UDiI7ccXH7i2AngzwZFxSQAheMrLtNjRfgR4
         2g2gdOMgVcU2G6pl6AraDrExF13K1lXAJD1VJlOdaAtk70+4JVVzOn9+1cm8qt2r+wbX
         9kkw==
X-Gm-Message-State: AOAM531lFIb95e2RUPBzqF3nSya9x0HcJVz0CpwuRxY+rCmD0TGB26Xm
        1fWga5at5cFd/fdFcbK3Fa9Z/w==
X-Google-Smtp-Source: ABdhPJzK2XUVwYEzIxK7kyMOxfYcu9Ot/TBK7K2adSoNhKewYU5KYOdn5DxEl72sB6jd1gpTdGqm8Q==
X-Received: by 2002:a17:902:bd03:: with SMTP id p3mr1610578pls.50.1644585858331;
        Fri, 11 Feb 2022 05:24:18 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f30sm11884656pgf.7.2022.02.11.05.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 05:24:17 -0800 (PST)
Subject: Re: [syzbot] possible deadlock in io_poll_double_wake (3)
To:     syzbot <syzbot+e654d4e15e6b3b9deb53@syzkaller.appspotmail.com>,
        alaaemadhossney.ae@gmail.com, asml.silence@gmail.com,
        dvyukov@google.com, hdanton@sina.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000098f75305d7ba7942@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c143b3f-c801-1906-27d1-be876272b1a0@kernel.dk>
Date:   Fri, 11 Feb 2022 06:24:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00000000000098f75305d7ba7942@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: io_uring: poll rework

-- 
Jens Axboe

