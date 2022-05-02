Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C810C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 16:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiEBQ1W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiEBQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FA5CAE48
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651508630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=To0IpXH9PCgmK1fMU29oJ6S0cNZrGFjYPD8Gg89v6y6UV5j6E3lPsd+06j3GWXrJW5BTk2
        mXcSuTgK+v/AsUZ0B1+P3dicIhPt6Ke5crlMoNS6mL8J+qiBy381NAAjz2Po9FmxEXgd5X
        TKu6OBglVFzQfczQt+uHrJsdXZ3cN5o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-6V7ilNgaP2WCZDPPac0TNA-1; Mon, 02 May 2022 12:23:46 -0400
X-MC-Unique: 6V7ilNgaP2WCZDPPac0TNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3ABCF3C02B63;
        Mon,  2 May 2022 16:23:46 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.194.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6669B40D2820;
        Mon,  2 May 2022 16:23:44 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, joro@8bytes.org, wanpengli@tencent.com
Subject: Re: [PATCH 0/3] Include MKTME KeyID bits to MMU shadow_zero_check
Date:   Mon,  2 May 2022 18:22:07 +0200
Message-Id: <20220502162207.541095-1-pbonzini@redhat.com>
In-Reply-To: <cover.1650363789.git.kai.huang@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Paolo


