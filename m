Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42457C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFXQBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1ABFE5251F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656086469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=TQfLA8WaTduKHwvEHD4JOaDZvjqa0vraUID9966uzO4d6bdrze8QxqCnGYBcgTXUwVLQ28
        GUnmA4FxDgTu0rZywIZXpbnBvv52qRKQguywgbesh8B3wrQopH7i1w7sdDzSNSujCP3KfI
        aX9CGqVUHW33youiwgj9O7zAkiLNB58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-p03-ZOvCMuiJoT99H3efMg-1; Fri, 24 Jun 2022 12:01:05 -0400
X-MC-Unique: p03-ZOvCMuiJoT99H3efMg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 536DD101AA46;
        Fri, 24 Jun 2022 16:01:05 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23421492CA5;
        Fri, 24 Jun 2022 16:01:05 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] KVM: debugfs: expose pid of vcpu threads
Date:   Fri, 24 Jun 2022 12:01:01 -0400
Message-Id: <20220624160101.2736816-1-pbonzini@redhat.com>
In-Reply-To: <20220523190327.2658-1-vineeth@bitbyteword.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


