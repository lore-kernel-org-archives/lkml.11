Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE57FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiDAAny (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiDAAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:43:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C70924ED88
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:42:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id e203so2276249ybc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 17:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+aH4s3B73YFGX6kkuTZiE+PkC6dF7JP+Qk/lqso9Lk=;
        b=g3oMD6fJzNOJ8cWbQWsZf+1h66em24oMTbli/L0GfBvNcUiUHG8fWvMpS+M5uEpSA7
         L1aUS++6665LSl6f3x9lzhYKAWrjj5jYFUe0jW+RYJWKAnVQkLNdh9EdzK19m4uNM2QE
         MqlRi0YjyWj0r+1tFPNwqBsVFM8GTdPtkt3Kaf7k7XLnQYQytLcZxHGHPLzbwF8G8iia
         tGPLIcnvWdaxfpqUeiwnnC19T3+BuraM4XDGfE3yJEq8TCq78ytnrxQOWrz7NoUOq6U9
         M0TEazP+HdkOJPCV5qODm91cWv2Yu48qCtKP9Ak8IElTiK7lDDIOzdqE55i6wZkfW2wD
         I7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+aH4s3B73YFGX6kkuTZiE+PkC6dF7JP+Qk/lqso9Lk=;
        b=M6zrPVs9FUGw9i5x+AXq47rnan0wumi4+fuLG/WuwKmsVkXnu15iVnyQgxGZdxHGVn
         Vr6sT5j9E/IumK9upgzTHM6QhCFqmH5llKejYtPVMpBTy1InrhGeAJvRsV3t3CvK1LtI
         s8iVerS3pdFHf6ttz14T8oZ7G2xDBS11J7Fcb25Boey7RVeOvEguVL3sXIQjIzAfj4Wh
         3/iRcsSD5eYq3/bVqEEUHeI/WyVLJPGPRyqKJDmOGPkfMIanW4l6L/+yvjOyRyCF888Q
         q2t0XELxgiHr8AF30g3mLG7IIiYLzlrV2p6+FHNJOibXi+83brM6e3Kzd0aYlRr1Mzr2
         YIBQ==
X-Gm-Message-State: AOAM533atJ/ArAtT1yOIY8/NjinxO+CvYWq8VHaeOcMEKnX01OWHpRr/
        DzHwGsoQpG/H+/Vu7NGENAtct0jbdWLF2qft0GMQOQ==
X-Google-Smtp-Source: ABdhPJzO+hJibgNFwPkxqdKK73AhMACKjcWsY5MC2ECXd+RdrUf6vd8YDiTUSKFKOpXcHt4R2WZkSQIuoHtQcazuqt0=
X-Received: by 2002:a25:4003:0:b0:633:8ab5:b93e with SMTP id
 n3-20020a254003000000b006338ab5b93emr6437060yba.387.1648773720439; Thu, 31
 Mar 2022 17:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <E1nZMdl-0006nG-0J@plastiekpoot> <CADVnQyn=A9EuTwxe-Bd9qgD24PLQ02YQy0_b7YWZj4_rqhWRVA@mail.gmail.com>
 <eaf54cab-f852-1499-95e2-958af8be7085@uls.co.za> <CANn89iKHbmVYoBdo2pCQWTzB4eFBjqAMdFbqL5EKSFqgg3uAJQ@mail.gmail.com>
 <10c1e561-8f01-784f-c4f4-a7c551de0644@uls.co.za> <CADVnQynf8f7SUtZ8iQi-fACYLpAyLqDKQVYKN-mkEgVtFUTVXQ@mail.gmail.com>
 <e0bc0c7f-5e47-ddb7-8e24-ad5fb750e876@uls.co.za> <CANn89i+Dqtrm-7oW+D6EY+nVPhRH07GXzDXt93WgzxZ1y9_tJA@mail.gmail.com>
 <CADVnQyn=VfcqGgWXO_9h6QTkMn5ZxPbNRTnMFAxwQzKpMRvH3A@mail.gmail.com>
 <5f1bbeb2-efe4-0b10-bc76-37eff30ea905@uls.co.za> <CANn89i+KsjGUppc3D8KLa4XUd-dzS3A+yDxbv2bRkDEkziS1qw@mail.gmail.com>
 <4b4ff443-f8a9-26a8-8342-ae78b999335b@uls.co.za>
In-Reply-To: <4b4ff443-f8a9-26a8-8342-ae78b999335b@uls.co.za>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 17:41:49 -0700
Message-ID: <CANn89iL203ZuRdcyxh16yKXqxXJW2u+4559DsDFmW=8S+_n7fg@mail.gmail.com>
Subject: Re: linux 5.17.1 disregarding ACK values resulting in stalled TCP connections
To:     Jaco Kroon <jaco@uls.co.za>
Cc:     Neal Cardwell <ncardwell@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 5:33 PM Jaco Kroon <jaco@uls.co.za> wrote:

> I'll deploy same on a dev host we've got in the coming week and start a
> bisect process.

Thanks, this will definitely help.
